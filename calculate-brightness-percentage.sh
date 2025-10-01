max=$(brightnessctl | grep -i 'max' | awk '{print $3}')
current=$(brightnessctl | grep -i 'current' | awk '{print $3}')
percentage=$(bc <<<"$current/$max*100")
trimmed=$(sed 's/.\{3\}$//' <<< "$percentage")
if redshift -p | grep -i 'daytime'; then
        echo "<span color='lightblue'>$trimmed%</span>" > $HOME/.config/i3status/brightness
else
        echo "<span color='orange'>$trimmed%</span>" > $HOME/.config/i3status/brightness
fi
killall -USR1 i3status

