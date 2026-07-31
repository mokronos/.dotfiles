#!/usr/bin/env bash

set -euo pipefail

snapshot="$("${HERDR_BIN_PATH:-herdr}" api snapshot)"
if [[ "${HERDR_PLUGIN_EVENT:-}" == "tab.focused" ]]; then
  workspace_id="${HERDR_WORKSPACE_ID:-}"
  tab_id="${HERDR_TAB_ID:-}"
else
  workspace_id="$(jq -r '.result.snapshot.focused_workspace_id // empty' <<<"$snapshot")"
  tab_id="$(jq -r '.result.snapshot.focused_tab_id // empty' <<<"$snapshot")"
fi
[[ -n "$workspace_id" && -n "$tab_id" ]] || exit 0

state_file="$HERDR_PLUGIN_STATE_DIR/$workspace_id"
exec 9>"$state_file.lock"
flock 9

declare -A valid_tabs=()
declare -A seen_tabs=(["$tab_id"]=1)
while IFS= read -r id; do
  valid_tabs["$id"]=1
done < <(jq -r --arg workspace_id "$workspace_id" '
  .result.snapshot.tabs[]
  | select(.workspace_id == $workspace_id)
  | .tab_id
' <<<"$snapshot")
[[ -n "${valid_tabs[$tab_id]:-}" ]] || exit 0

history=()
if [[ -f "$state_file" ]]; then
  mapfile -t history <"$state_file"
fi

tmp="$state_file.tmp.$$"
{
  printf '%s\n' "$tab_id"
  count=1
  for candidate in "${history[@]}"; do
    [[ -n "$candidate" ]] || continue
    [[ -n "${valid_tabs[$candidate]:-}" && -z "${seen_tabs[$candidate]:-}" ]] || continue
    seen_tabs["$candidate"]=1
    printf '%s\n' "$candidate"
    count=$((count + 1))
    (( count < 20 )) || break
  done
} >"$tmp"
mv "$tmp" "$state_file"
