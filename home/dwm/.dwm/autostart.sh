setxkbmap us,ru ,winkeys grp:alt_shift_toggle &
$HOME/.local/scripts/status/launch &
$HOME/.local/scripts/touchpad.sh
xrandr --output HDMI1 --off; enact --pos top
enact --pos top &
firefox &
setxkbmap us,ru ,winkeys grp:alt_shift_toggle &
nitrogen --restore
enact --pos top --watch &
cd /home/horhik/Freenet/downloads/fms; ./fms --daemon
picom --experimental-backends --detect-rounded-corners &
deadd-notification-center &
sleep 10; pulseaudio -k &
