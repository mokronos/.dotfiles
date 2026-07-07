#!/usr/bin/env bash

launch_with_rule() {
  local workspace="$1"
  local command="$2"

  hyprctl dispatch exec "[workspace $workspace silent] $command"
  sleep 0.6
}

npx --yes t3@nightly serve --host "::" --port 3773 &
hyprctl dispatch moveworkspacetomonitor 5 DP-1

launch_with_rule 1 "xdg-terminal-exec"
launch_with_rule 1 "google-chrome-stable --new-window"
launch_with_rule 2 "google-chrome-stable --new-window"
launch_with_rule 3 "steam"
launch_with_rule 4 "discord"
launch_with_rule 5 "google-chrome-stable --new-window http://localhost:3773"
