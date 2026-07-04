#!/usr/bin/env bash
set -euo pipefail

codex_json="$(timeout 55 codexbar usage --provider codex --format json --no-color 2>/dev/null || printf '[]')"
claude_json="$(timeout 55 codexbar usage --provider claude --format json --no-color 2>/dev/null || printf '[]')"

if ! jq -e . >/dev/null 2>&1 <<<"$codex_json"; then
  codex_json='[]'
fi

if ! jq -e . >/dev/null 2>&1 <<<"$claude_json"; then
  claude_json='[]'
fi

jq -n --argjson codex "$codex_json" --argjson claude "$claude_json" '
  def first_item: if type == "array" then (.[0] // {}) else (. // {}) end;
  def pct($usage; $window):
    ($usage[$window].usedPercent // null) as $value
    | if $value == null then "?" else ($value | tostring) + "%" end;
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
  | ($cu.codexResetCredits.credits // [] | map(credit_line) | join("\n")) as $credit_lines
  | {
      text: ("CX " + pct($cu; "primary") + "/" + pct($cu; "secondary") + " CL " + pct($au; "primary") + "/" + pct($au; "secondary") + " R" + ($credits | tostring)),
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
