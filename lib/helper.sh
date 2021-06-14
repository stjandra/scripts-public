#!/usr/bin/env bash

# Helper functions.

# Read input from stdin or arguments.
# From
# https://zwbetz.com/passing-input-to-a-bash-function-via-arguments-or-stdin/
read_input() {
    if [[ -p /dev/stdin ]]; then
        input="$(cat -)"
    else
        input="${*}"
    fi

    if [[ -z "${input}" ]]; then
        return 1
    fi

    echo "$input"
}

output() {
    echo "$@"
}

# $1 The file to source.
source_if_exists() {

    if [ -f "$1" ]; then
        output "Using constants file $1"
        # shellcheck disable=SC1090
        source "$1"
        return 0
    fi

    return 1
}