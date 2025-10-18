#!/bin/bash


music_playing_player=""

# Get list of MPRIS player names from qdbus output
players=$(qdbus | grep org.mpris.MediaPlayer2 | awk -F '.' '{print $NF}')

for player in $players; do
    player_status=$(playerctl -p "$player" status)
    if [[ "$player_status" == "Playing" ]]; then
        music_playing_player="$player"
        break
    fi
done

# Get player playerctl_status (Playing, Paused, or Stopped)
playerctl_status=$(playerctl -p "$music_playing_player" status 2>/dev/null)


if [ "$playerctl_status" = "Playing" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    echo "{\"text\":\"▶ $artist - $title\", \"class\":\"playing\"}"
elif [ "$playerctl_status" = "Paused" ]; then
    artist=$(playerctl metadata artist 2>/dev/null)
    title=$(playerctl metadata title 2>/dev/null)
    echo "{\"text\":\"⏸ $artist - $title\", \"class\":\"paused\"}"
else
    echo "{\"text\":\"No media playing\", \"class\":\"stopped\"}"
fi

