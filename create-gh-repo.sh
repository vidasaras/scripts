#!/bin/bash

GITHUB_TOKEN="$HOME/.config/github/token"
USERNAME="vidasaras"

repo_name="$1"
[ -z "$repo_name" ] && {
    msg="Missing repo name!"
    [ -n "$QUTE_FIFO" ] && echo ":message-warning ${msg// /\\ }" > "$QUTE_FIFO" || echo "$msg"
    exit 1
}

token=$(< "$GITHUB_TOKEN")

response=$(curl -s -H "Authorization: token $token" \
  -d "{\"name\":\"$repo_name\"}" \
  https://api.github.com/user/repos)

html_url=$(echo "$response" | jq -r '.html_url // empty')

if [ -n "$html_url" ]; then
    msg="Repo '$repo_name' created successfully."
    if [ -n "$QUTE_FIFO" ]; then
        echo ":message-info ${msg// /\\ }" > "$QUTE_FIFO"
        echo ":open -t $html_url" > "$QUTE_FIFO"
    else
        echo "$msg"
        echo "URL: $html_url"
    fi
else
    error_msg=$(echo "$response" | jq -r '.message // "Unknown error"')
    msg="Failed to create repo: $error_msg"
    [ -n "$QUTE_FIFO" ] && echo ":message-warning ${msg// /\\ }" > "$QUTE_FIFO" || echo "$msg"
fi

