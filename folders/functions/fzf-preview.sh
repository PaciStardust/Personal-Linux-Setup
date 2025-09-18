#!/bin/zsh
if [ -f "$1" ]; then
    stat "$1" --printf='Type: %F | Size: %s | Access: %A\nGroup: %G(%g) | Owner: %U(%u)\nCreated: %w\nModified: %y\n'
    echo '--------------------------------------------------------------------------------------------------------'
    if command -v batcat >/dev/null; then
        batcat "$1" --style=plain --color=always --theme="$BAT_THEME" --line-range=:500
    elif 
        bat "$1" --style=plain --color=always --theme="$BAT_THEME" --line-range=:500
    fi
elif [ -d "$1" ]; then
    stat "$1" --printf='Type: %F | Size: %s | Access: %A\nGroup: %G(%g) | Owner: %U(%u)\nCreated: %w\nModified: %y\n'
    echo '--------------------------------------------------------------------------------------------------------'
    ls "$1" -A --color
fi
