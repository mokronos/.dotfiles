#!/usr/bin/env bash

LOG="$HOME/.local/state/omarchy/startup-restore-debug.log"

log() {
  echo "$(date '+%Y-%m-%d %H:%M:%S') [script] $*" >>"$LOG"
}

launch_with_rule() {
  local workspace="$1"
  local command="$2"

  log "launching ws=$workspace: $command"
  # Hyprland 0.56 exposes dispatchers through its Lua interface. The old
  # `hyprctl dispatch exec ...` form is now parsed as invalid Lua.
  if ! hyprctl eval "hl.dispatch(hl.dsp.exec_cmd([[[workspace $workspace silent] $command]]))" >>"$LOG" 2>&1; then
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

# Ghostty's config starts Herdr as the terminal command. Do not use
# xdg-terminal-exec here because Omarchy's default currently resolves to Foot.
launch_with_rule 1 "ghostty"
# Launch once so Zen restores its own windows and tabs.
launch_with_rule 1 "zen-browser"
launch_with_rule 3 "steam"
launch_with_rule 4 "discord"
launch_with_rule 5 "$HOME/.local/bin/t3code-nightly"

log "=== script finished ==="
