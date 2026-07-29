#!/usr/bin/env bash

set -euo pipefail

workspace_id="${HERDR_WORKSPACE_ID:-}"
tab_id="${HERDR_TAB_ID:-}"
[[ -n "$workspace_id" && -n "$tab_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/$workspace_id"
exec 9>"$state_file.lock"
flock 9
[[ -f "$state_file" ]] || exit 0

mapfile -t history <"$state_file"
current="${history[0]:-}"
previous="${history[1]:-}"

if [[ "$tab_id" == "$current" ]]; then
  target="$previous"
elif [[ "$tab_id" == "$previous" ]]; then
  target="$current"
else
  exit 0
fi

[[ "$target" == "$workspace_id":* ]] || exit 0
"${HERDR_BIN_PATH:-herdr}" tab focus "$target" >/dev/null
