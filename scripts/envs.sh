#!/usr/bin/env bash

# FROM: https://github.com/sainnhe/tmux-fzf/blob/master/scripts/.envs

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

compare_float() {
  if [ ${1%.*} -eq ${2%.*} ] && [ ${1#*.} \> ${2#*.} ] || [ ${1%.*} -gt ${2%.*} ]; then
    echo ">"
  else
    echo "<="
  fi
}

# $TMUXP_FZF_PREVIEW_OPTIONS
fzf_version=$(fzf --version)
fzf_version_1=$(echo "$fzf_version" | grep -o '^[[:digit:]]*\.[[:digit:]]*')
fzf_version_2=$(echo "$fzf_version" | grep -o '^[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*' | sed 's/[[:digit:]]*\.//')
if [ $(compare_float $fzf_version_1 "0.24") == ">" ] ||
  [ $fzf_version_1 == "0.24" ] &&
  [ $(compare_float $fzf_version_2 "24.3") == ">" ]; then
  fzf_preview_window_follow=":follow" # :follow option is only available in fzf >= 0.24.4
fi
TMUXP_FZF_PREVIEW="${TMUXP_FZF_PREVIEW:-1}"
if [ "$TMUXP_FZF_PREVIEW" == 1 ]; then
  TMUXP_FZF_PREVIEW_OPTIONS="--preview='$current_dir/.preview {}' --preview-window=$fzf_preview_window_follow"
else
  TMUXP_FZF_PREVIEW_OPTIONS="--preview='$current_dir/.preview {}' --preview-window=${fzf_preview_window_follow}:hidden"
fi

# $TMUXP_FZF_BIN
TMUXP_FZF_BIN="$current_dir/fzf-tmux.sh"

# $TMUXP_FZF_OPTIONS
tmux_version=$(tmux -V | grep -oE '[0-9]+\.[0-9]*')
if [ $(compare_float $tmux_version "3.1") == ">" ]; then
  [ -z "$TMUXP_FZF_OPTIONS" ] && TMUXP_FZF_OPTIONS="-p -w 62% -h 38%"
fi

# Unset temporary variables and functions.
unset \
  current_dir \
  compare_float \
  fzf_version \
  fzf_version_1 \
  fzf_version_2 \
  fzf_preview_window_follow \
  tmux_version
