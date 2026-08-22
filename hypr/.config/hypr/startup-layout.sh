#!/usr/bin/env bash

LOG="$HOME/.local/state/omarchy/startup-restore-debug.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [script] $*" >>"$LOG"
}

launch_with_rule() {
  local workspace="$1"
  local command="$2"

  log "launching ws=$workspace: $command"
  if ! hyprctl dispatch exec "[workspace $workspace silent] $command" >>"$LOG" 2>&1; then
    log "ERROR: hyprctl failed for ws=$workspace cmd=$command"
  fi
  sleep 0.6
}

log "=== script started (pid $$) ==="
log "HYPRLAND_INSTANCE_SIGNATURE=${HYPRLAND_INSTANCE_SIGNATURE:-<unset>}"
log "WAYLAND_DISPLAY=${WAYLAND_DISPLAY:-<unset>}"
command -v hyprctl >/dev/null || log "ERROR: hyprctl not in PATH"
hyprctl version 2>&1 | head -1 | sed 's/^/[script] hyprctl check: /' >>"$LOG" || log "ERROR: hyprctl version failed"

if monitor=$(hyprctl monitors 2>/dev/null | grep -m1 '^Monitor'); then
  log "monitor check: $monitor"
else
  log "WARNING: could not query monitors"
fi

hyprctl dispatch moveworkspacetomonitor 5 DP-1 >>"$LOG" 2>&1

launch_with_rule 1 "xdg-terminal-exec"
# Zen restores its previous session itself; no restore flag exists
launch_with_rule 1 "zen-browser"
launch_with_rule 2 "zen-browser --new-window"
launch_with_rule 3 "steam"
launch_with_rule 4 "discord"
launch_with_rule 5 "zen-browser --new-window http://localhost:3773"

log "=== script finished ==="
