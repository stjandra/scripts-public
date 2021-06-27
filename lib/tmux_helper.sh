#!/usr/bin/env bash

# tmux helper functions.

# Whether we are in a tmux session.
is_in_tmux() {
    [ -n "$TMUX" ]
}

# Rename tmux window to $@.
rename_tmux_window() {
    is_in_tmux && tmux rename-window "$@"
}

# Restore the tmux window name.
restore_tmux_window_name() {
    is_in_tmux && tmux setw automatic-rename
}

# Rename tmux window to $1 and evaluate ${@:2}.
run_cmd_tmux() {

    rename_tmux_window "$1"

    # ${@:2} - all arguments except the 1st one.
    # shellcheck disable=SC3057
    eval "${@:2}"

    restore_tmux_window_name
}
