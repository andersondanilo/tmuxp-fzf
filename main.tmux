#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[ -z "$TMUXP_FZF_LAUNCH_KEY" ] && TMUXP_FZF_LAUNCH_KEY="P"
tmux bind-key "$TMUXP_FZF_LAUNCH_KEY" run-shell -b "$CURRENT_DIR/main.sh"
