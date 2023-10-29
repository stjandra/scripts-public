#!/usr/bin/env bash

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@
}

get_volume_percentage() {
    get_volume | cut -d' ' -f2 | awk '{ printf "%.0f%\n", $1 * 100 }'
}

notify_volume() {
    # https://wiki.archlinux.org/title/Dunst#Using_dunstify_as_volume/brightness_level_indicator
    dunstify -u low -t 2000\
        -i audio-volume-medium \
        -h string:x-dunst-stack-tag:volumeChange \
        -h int:value:"$1" "Volume: $1"
}

is_muted() {
    echo $(get_volume) | grep -qF MUTED
}
