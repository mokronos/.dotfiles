#!/usr/bin/env bash
set -euo pipefail

cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/waybar-ai-limits"
mkdir -p "$cache_dir"

provider_json() {
  local provider="$1"
  local cache_file="$cache_dir/$provider.json"
  local payload

  if payload="$(timeout 45 codexbar usage --provider "$provider" --format json --no-color 2>/dev/null)" && jq -e 'if type == "array" then .[0].usage.primary.usedPercent != null else .usage.primary.usedPercent != null end' >/dev/null 2>&1 <<<"$payload"; then
    jq -c . <<<"$payload" >"$cache_file"
    jq -c . "$cache_file"
  elif [[ -r $cache_file ]]; then
    jq -c . "$cache_file"
  else
    printf '[]'
  fi
}

codex_json="$(provider_json codex)"
claude_json="$(provider_json claude)"

jq -cn --argjson codex "$codex_json" --argjson claude "$claude_json" '
  def first_item: if type == "array" then (.[0] // {}) else (. // {}) end;
  def pct($usage; $window):
    ($usage[$window].usedPercent // null) as $value
    | if $value == null then "?" else ($value | tostring) + "%" end;
  def reset_hours($usage; $window):
    ($usage[$window].resetsAt // null) as $iso
    | if $iso == null then "?" else (((($iso | fromdateiso8601) - now) / 3600 | if . < 0 then 0 else . end) * 10 | round / 10 | tostring) + "h" end;
  def limit($usage; $window): pct($usage; $window) + "(" + reset_hours($usage; $window) + ")";
  def credit_expiry_days($credits):
    ($credits | map(.expires_at // empty | fromdateiso8601) | min) as $expiry
    | if $expiry == null then "?" else (((($expiry - now) / 86400) | if . < 0 then 0 else . end) | ceil | tostring) + "d" end;
  def used($usage; $window): $usage[$window].usedPercent // 0;
  def when($usage; $window):
    ($usage[$window].resetsAt // null) as $iso
    | if $iso == null then "unknown" else ($iso | fromdateiso8601 | strflocaltime("%a %H:%M")) end;
  def credit_line:
    "- " + (.title // "Reset") + " expires " + (.expires_at | fromdateiso8601 | strflocaltime("%b %d %H:%M"));

  ($codex | first_item | .usage // {}) as $cu
  | ($claude | first_item | .usage // {}) as $au
  | ($cu.codexResetCredits.availableCount // ($cu.codexResetCredits.credits // [] | length) // 0) as $credits
  | ([used($cu; "primary"), used($cu; "secondary"), used($au; "primary"), used($au; "secondary")] | max) as $max_used
  | ($cu.codexResetCredits.credits // []) as $reset_credits
  | ($reset_credits | map(credit_line) | join("\n")) as $credit_lines
  | {
      text: ("C5 " + limit($cu; "primary") + " Cw " + limit($cu; "secondary") + " R" + ($credits | tostring) + "(" + credit_expiry_days($reset_credits) + ") A5 " + limit($au; "primary") + " Aw " + limit($au; "secondary")),
      tooltip: (
        "Codex\n" +
        "5h: " + pct($cu; "primary") + " resets " + when($cu; "primary") + "\n" +
        "Weekly: " + pct($cu; "secondary") + " resets " + when($cu; "secondary") + "\n" +
        "Reset credits: " + ($credits | tostring) +
        (if $credit_lines == "" then "" else "\n" + $credit_lines end) +
        "\n\nClaude\n" +
        "5h: " + pct($au; "primary") + " resets " + when($au; "primary") + "\n" +
        "Weekly: " + pct($au; "secondary") + " resets " + when($au; "secondary")
      ),
      class: (if $max_used >= 90 then "critical" elif $max_used >= 75 then "warning" else "normal" end)
    }
'
