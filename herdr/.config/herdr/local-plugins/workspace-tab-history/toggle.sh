#!/usr/bin/env bash

set -euo pipefail

workspace_id="${HERDR_WORKSPACE_ID:-}"
tab_id="${HERDR_TAB_ID:-}"
[[ -n "$workspace_id" && -n "$tab_id" ]] || exit 0
herdr="${HERDR_BIN_PATH:-herdr}"

state_file="$HERDR_PLUGIN_STATE_DIR/$workspace_id"
exec 9>"$state_file.lock"
flock 9
[[ -f "$state_file" ]] || exit 0

snapshot="$("$herdr" api snapshot)"
declare -A valid_tabs=()
declare -A seen_tabs=(["$tab_id"]=1)
while IFS= read -r id; do
  valid_tabs["$id"]=1
done < <(jq -r --arg workspace_id "$workspace_id" '
  .result.snapshot.tabs[]
  | select(.workspace_id == $workspace_id)
  | .tab_id
' <<<"$snapshot")

mapfile -t history <"$state_file"
target=""
tmp="$state_file.tmp.$$"
{
  printf '%s\n' "$tab_id"
  for candidate in "${history[@]}"; do
    [[ -n "$candidate" ]] || continue
    [[ -n "${valid_tabs[$candidate]:-}" && -z "${seen_tabs[$candidate]:-}" ]] || continue
    seen_tabs["$candidate"]=1
    [[ -n "$target" ]] || target="$candidate"
    printf '%s\n' "$candidate"
  done
} >"$tmp"
mv "$tmp" "$state_file"

[[ -n "$target" ]] || exit 0
"$herdr" tab focus "$target" >/dev/null
