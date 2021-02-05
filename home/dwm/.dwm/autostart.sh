setxkbmap us,ru ,winkeys grp:alt_shift_toggle &
pulseaudio -k 
$HOME/.local/scripts/status/launch &
$HOME/.local/scripts/touchpad.sh
xrandr --output HDMI1 --off; enact --pos top
enact --pos top
firefox &
superproductivity &
setxkbmap us,ru ,winkeys grp:alt_shift_toggle &
nitrogen --restore
enact --pos top --watch &
nextcloud &
cd /home/horhik/Freenet/downloads/fms; ./fms --daemon
picom --experimental-backends --detect-rounded-corners &
