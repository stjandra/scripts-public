#!/usr/bin/env bash

# pactl helper functions.

get_sink() {

    # Try to get the running sink
    SINK=$(pactl list sinks short | grep RUNNING | cut -d$'\t' -f1)

    # Get the 1st sink if none is running
    [ -z "$SINK" ] && SINK=$(pactl list sinks short | head -n1 | cut -d$'\t' -f1)

    echo "$SINK"
}

get_volume() {

    SINK=$(get_sink)

    # xargs to remove spaces
    # https://stackoverflow.com/a/12973694
    pactl get-sink-volume "$SINK" | grep Volume | cut -d'/' -f2 | xargs
}

is_muted() {

    SINK=$(get_sink)

    pactl get-sink-mute "$SINK" | grep -q yes
}

notify_volume() {
    # https://wiki.archlinux.org/title/Dunst#Using_dunstify_as_volume/brightness_level_indicator
    dunstify -u low -h string:x-dunst-stack-tag:volumeChange "$1"

    dunstify -u low -t 2000\
        -i audio-volume-high \
        -h string:x-dunst-stack-tag:volumeChange \
        -h int:value:"$1" "Volume: $1"
}
