#!/usr/bin/env bash

launch_on_workspace() {
  local workspace="$1"
  local command="$2"

  hyprctl dispatch workspace "$workspace"
  sleep 0.25
  hyprctl dispatch exec "$command"
  sleep 0.75
}

launch_on_workspace 1 "xdg-terminal-exec"
launch_on_workspace 1 "google-chrome-stable --new-window"
launch_on_workspace 2 "google-chrome-stable --new-window"
launch_on_workspace 3 "steam"
launch_on_workspace 4 "discord"

hyprctl dispatch workspace 1
