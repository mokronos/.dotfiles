#!/usr/bin/env bash

set -euo pipefail

herdr="${HERDR_BIN_PATH:-herdr}"
snapshot="$("$herdr" api snapshot)"
workspace_id="$(jq -r '.result.snapshot.focused_workspace_id // empty' <<<"$snapshot")"
[[ -n "$workspace_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/workspaces"
exec 9>"$state_file.lock"
flock 9
[[ -f "$state_file" ]] || exit 0

declare -A valid_workspaces=()
while IFS= read -r id; do
  valid_workspaces["$id"]=1
done < <(jq -r '.result.snapshot.workspaces[].workspace_id' <<<"$snapshot")

declare -A seen_workspaces=()
valid_history=()
while IFS= read -r id; do
  [[ -n "$id" && -n "${valid_workspaces[$id]:-}" && -z "${seen_workspaces[$id]:-}" ]] || continue
  seen_workspaces["$id"]=1
  valid_history+=("$id")
done <"$state_file"

printf '%s\n' "${valid_history[@]}" >"$state_file"
current="${valid_history[0]:-}"
previous="${valid_history[1]:-}"

if [[ "$workspace_id" == "$current" ]]; then
  target="$previous"
elif [[ "$workspace_id" == "$previous" ]]; then
  target="$current"
else
  exit 0
fi

[[ -n "$target" ]] || exit 0
"$herdr" workspace focus "$target" >/dev/null
