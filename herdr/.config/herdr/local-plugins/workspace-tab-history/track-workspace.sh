#!/usr/bin/env bash

set -euo pipefail

workspace_id="$("${HERDR_BIN_PATH:-herdr}" api snapshot \
  | jq -r '.result.snapshot.focused_workspace_id // empty')"
[[ -n "$workspace_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/workspaces"
exec 9>"$state_file.lock"
flock 9

current=""
if [[ -f "$state_file" ]]; then
  IFS= read -r current <"$state_file" || true
fi

if [[ "$workspace_id" != "$current" ]]; then
  printf '%s\n%s\n' "$workspace_id" "$current" >"$state_file"
fi
