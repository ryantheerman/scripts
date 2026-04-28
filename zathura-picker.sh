#!/bin/sh
#selected="$(fd . --type f --extension pdf "$HOME/Documents" "$HOME/Downloads" "$HOME/projects" | fuzzel --dmenu --prompt 'PDF > ')"
#[ -n "$selected" ] && nohup zathura "$selected" >/dev/null 2>&1 &

#!/bin/sh
selected="$(fd . "$HOME/Documents" "$HOME/Downloads" "$HOME/projects" --type f --extension pdf \
    | sed "s|$HOME|~|g" \
    | fuzzel --width 110 --dmenu --prompt 'pdf launcher > ')"
[ -n "$selected" ] && nohup zathura "${selected/#\~/$HOME}" >/dev/null 2>&1 &
