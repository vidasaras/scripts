#!/bin/bash

HISTORY_FILE="$HOME/.cache/clipboard_history"

# Ensure history file exists
touch "$HISTORY_FILE"

# Function to add item to history
add_item() {
    local item="$(xclip -o -selection clipboard | sed ':a;N;$!ba;s/\n/\\NOL%/g')"
    grep -Fxq "$item" "$HISTORY_FILE" || echo "$item" >> "$HISTORY_FILE"
}

# Function to delete item from history
delete_item() {
    local item="$1"
    grep -Fxv "$item" "$HISTORY_FILE" > "$HISTORY_FILE.tmp" && mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
}

# Function to show history using dmenu
show_history() {
    local selection=$(tac "$HISTORY_FILE" | dmenu -l 10)
    [ -n "$selection" ] && echo "$selection" | sed 's/\\NOL%/\n/g' | xclip -selection clipboard
}

# Function to clear history
clear_history() {
    > "$HISTORY_FILE"
}

# Handle script arguments
case "$1" in
    add)
        add_item 
        ;;
    delete)
        delete_item "$(tac "$HISTORY_FILE" | dmenu -l 10)"
        ;;
    show)
        show_history
        ;;
    clear)
        clear_history
        ;;
    *)
        echo "Usage: $0 {add|delete|show|clear}" >&2
        exit 1
        ;;
esac
