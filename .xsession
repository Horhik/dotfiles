set $TERMINAL alacritty
export TERMINAL=alacritty


xrdb -merge .Xresources
xpmroot ~/background.xpm &

$HOME/bin/xmonad

