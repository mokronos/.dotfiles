#!/usr/bin/env bash

set -euo pipefail

workspace_id="$("${HERDR_BIN_PATH:-herdr}" api snapshot \
  | jq -r '.result.snapshot.focused_workspace_id // empty')"
[[ -n "$workspace_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/workspaces"
exec 9>"$state_file.lock"
flock 9
[[ -f "$state_file" ]] || exit 0

mapfile -t history <"$state_file"
current="${history[0]:-}"
previous="${history[1]:-}"

if [[ "$workspace_id" == "$current" ]]; then
  target="$previous"
elif [[ "$workspace_id" == "$previous" ]]; then
  target="$current"
else
  exit 0
fi

[[ -n "$target" ]] || exit 0
"${HERDR_BIN_PATH:-herdr}" workspace focus "$target" >/dev/null
