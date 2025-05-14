#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <file.md>"
    exit 1
fi

if ! command -v pandoc &> /dev/null; then
    echo "Error: pandoc is not installed. Install it with 'sudo apt install pandoc'"
    exit 1
fi

if command -v bat &> /dev/null; then
    pandoc "$1" -t plain | bat --paging=always --language=md
else
    pandoc "$1" -t plain | less -R
fi
