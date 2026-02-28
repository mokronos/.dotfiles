#!/usr/bin/env bash

launch_with_rule() {
  local workspace="$1"
  local command="$2"

  hyprctl dispatch exec "[workspace $workspace silent] $command"
  sleep 0.6
}

launch_with_rule 1 "xdg-terminal-exec"
launch_with_rule 1 "google-chrome-stable --new-window"
launch_with_rule 2 "google-chrome-stable --new-window"
launch_with_rule 3 "steam"
launch_with_rule 4 "discord"
