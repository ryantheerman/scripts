#! /bin/bash

# this script is a bit of a hack.
# for some reason I'm not yet sure of, my x configs sometimes get borked after a system update. something to do with pacman hooks??? gotta look into it.
# but for now, this script resets my x configs which are typically initialized in .xinitrc.
# xinit has some other calls which are not affected by the system update issue, so they're not included here (redshift & and picom & for instance).
# there's probably a better way to set some of these configs, but it needs research. don't have the time right now (but I will in future, right? right?), so here's this hack.
# i'll hook it to the end of pacman -Syu or something.
# but maybe I shouldn't actually. the update doesn't ALWAYS cause a problem. do i run into trouble running some of these settings on top of each other?
# i think maybe just doubling/tripling etc the xcape settings. will test.

#if [ $USER == 'root' ]; then
#    echo 'Resetting x configs after system upgrade...'
#fi

setxkbmap us -v dvorak 1> /dev/null
xset r rate 200 30
xset s 1800 1800 +dpms
xmodmap /home/match/.Xmodmap
#xcape -e 'Hyper_R=Escape'

# below xcape config seems unaffected by the system update issue. running it twice (at xinit and after update) seems to cause trouble)
#xcape -e 'Control_L=Control_L|a'

xinput set-button-map 14 1 1 3 4 5 6 7
xinput set-button-map 10 1 1 3 4 5 6 7
               
xrdb /home/match/.Xresources

# okay yes, disabling the xcape left control setting lets me run this scripts with no unexpected behavior. it's idempotent but for that line.
