#!/usr/bin/env bash

# pactl helper functions.

get_running_sink() {
    pactl list sinks short | grep RUNNING | cut -d$'\t' -f1
}
