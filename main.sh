#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

[[ -z "$TMUXP_BIN" ]] && TMUXP_BIN="tmuxp"

source "$CURRENT_DIR/scripts/envs.sh"

items_origin="$($TMUXP_BIN ls)"

item=$(echo "$items_origin" | eval "$TMUXP_FZF_BIN $TMUXP_FZF_OPTIONS")

[[ -z "$item" ]] && exit

$TMUXP_BIN load --yes $item > /dev/null
