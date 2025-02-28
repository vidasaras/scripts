#!/bin/bash
HISTORY_SCRIPT="$HOME/dev/scripts/cliphis.sh"

while true; do
    # Get the current clipboard content
    clipboard_content=$(xclip -selection clipboard -o)
    
    # If clipboard content has changed
    if [ "$clipboard_content" != "$previous_clipboard" ]; then
        "$HISTORY_SCRIPT" add 
        previous_clipboard="$clipboard_content"
    fi
    
    # Sleep briefly to avoid high CPU usage
    sleep 1
done
