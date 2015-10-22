xrdb -merge /home/martin/.Xresources

# map esc to caps lock
# see superuser.com/questions/566871
setxkbmap -option caps:escape

while true
do
    LOCALTIME=$(date +%A\ %Y-%m-%d\ %H:%M)
    BAT_PCT=$(acpi | awk '{ print $4-0 }')%
    BAT_TIME=$(acpi | awk '{ print $5 }')
    xsetroot -name "$BAT_PCT ($BAT_TIME) $LOCALTIME"
    sleep 20
done &

# bind volume keys (see ~/.xbindkeysrc)
xbindkeys

# start dropbox daemon
/home/martin/.dropbox-dist/dropboxd &

/usr/bin/dwm
