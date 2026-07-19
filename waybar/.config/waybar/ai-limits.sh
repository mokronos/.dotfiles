#!/usr/bin/env bash
set -euo pipefail

provider="${1:-codex}"
cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-ai-limits"
mkdir -p "$cache_dir"

provider_json() {
  local provider="$1"
  local cache_file="$cache_dir/$provider.json"
  local payload

  if [[ -r $cache_file ]] && (( $(date +%s) - $(stat -c %Y "$cache_file") < 240 )); then
    jq -c . "$cache_file"
    return
  fi

  if payload="$(timeout 45 codexbar usage --provider "$provider" --format json --no-color 2>/dev/null)" && jq -e 'if type == "array" then ((.[0].usage.primary.usedPercent != null) or (.[0].usage.secondary.usedPercent != null)) else ((.usage.primary.usedPercent != null) or (.usage.secondary.usedPercent != null)) end' >/dev/null 2>&1 <<<"$payload"; then
    jq -c . <<<"$payload" >"$cache_file"
    jq -c . "$cache_file"
  elif [[ -r $cache_file ]]; then
    jq -c . "$cache_file"
  else
    printf '[]'
  fi
}

usage_json="$(provider_json "$provider")"

jq -cn --arg provider "$provider" --argjson payload "$usage_json" '
  def first_item: if type == "array" then (.[0] // {}) else (. // {}) end;
  def pct($usage; $window):
    ($usage[$window].usedPercent // null) as $value
    | if $value == null then "?" else ($value | tostring) + "%" end;
  def reset_hours($usage; $window):
    ($usage[$window].resetsAt // null) as $iso
    | if $iso == null then "?" else (((($iso | fromdateiso8601) - now) / 3600 | if . < 0 then 0 else . end) * 10 | round / 10 | tostring) + "h" end;
  def limit($usage; $window): pct($usage; $window) + "(" + reset_hours($usage; $window) + ")";
  def when($usage; $window):
    ($usage[$window].resetsAt // null) as $iso
    | if $iso == null then "unknown" else ($iso | fromdateiso8601 | strflocaltime("%a %H:%M")) end;
  def has_window($usage; $window): $usage[$window].usedPercent != null;
  def limits_text($usage):
    if has_window($usage; "primary") and has_window($usage; "secondary") then limit($usage; "primary") + "/" + limit($usage; "secondary")
    elif has_window($usage; "primary") then limit($usage; "primary")
    elif has_window($usage; "secondary") then limit($usage; "secondary")
    else "?" end;
  def window_tooltip($usage; $label; $window):
    if has_window($usage; $window) then "\n" + $label + ": " + pct($usage; $window) + " resets " + when($usage; $window) else "" end;
  def credit_expiry_hours($credits):
    ($credits | map(.expires_at // empty | fromdateiso8601) | min) as $expiry
    | if $expiry == null then "?" else (((($expiry - now) / 3600) | if . < 0 then 0 else . end) * 10 | round / 10 | tostring) + "h" end;
  def used($usage; $window): $usage[$window].usedPercent // 0;
  def credit_line:
    "- " + (.title // "Reset") + " expires " + (.expires_at | fromdateiso8601 | strflocaltime("%b %d %H:%M"));

  ($payload | first_item | .usage // {}) as $usage
  | ([used($usage; "primary"), used($usage; "secondary")] | max) as $max_used
  | ($usage.codexResetCredits // null) as $reset_credit_data
  | (if $reset_credit_data == null then null else ($reset_credit_data.availableCount // ($reset_credit_data.credits // [] | length)) end) as $credits
  | ($reset_credit_data.credits // []) as $reset_credits
  | ($reset_credits | map(credit_line) | join("\n")) as $credit_lines
  | {
      text: (limits_text($usage) + if $provider == "codex" and $credits != null then " R" + ($credits | tostring) + "(" + credit_expiry_hours($reset_credits) + ")" else "" end),
      tooltip: ((if $provider == "codex" then "Codex" else "Claude" end) +
        window_tooltip($usage; "5h"; "primary") +
        window_tooltip($usage; "Weekly"; "secondary") +
        (if $provider == "codex" and $credits != null then "\nReset credits: " + ($credits | tostring) + (if $credit_lines == "" then "" else "\n" + $credit_lines end) else "" end)
      ),
      class: (if $max_used >= 90 then "critical" elif $max_used >= 75 then "warning" else "normal" end)
    }
'
