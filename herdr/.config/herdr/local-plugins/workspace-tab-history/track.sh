#!/usr/bin/env bash

set -euo pipefail

snapshot="$("${HERDR_BIN_PATH:-herdr}" api snapshot)"
workspace_id="$(jq -r '.result.snapshot.focused_workspace_id // empty' <<<"$snapshot")"
tab_id="$(jq -r '.result.snapshot.focused_tab_id // empty' <<<"$snapshot")"
[[ -n "$workspace_id" && -n "$tab_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/$workspace_id"
exec 9>"$state_file.lock"
flock 9

current=""
if [[ -f "$state_file" ]]; then
  IFS= read -r current <"$state_file" || true
fi

if [[ "$tab_id" != "$current" ]]; then
  printf '%s\n%s\n' "$tab_id" "$current" >"$state_file"
fi
