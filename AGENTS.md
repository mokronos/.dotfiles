# AGENTS.md

- Keep all config changes synced with ~/.dotfiles.
- After any change, commit and push it from ~/.dotfiles.
- When modifying config, use a separate worktree to avoid breaking live symlinked configs.
- Keep hardware and startup setups branch-specific when appropriate; check `/sys/class/dmi/id/chassis_type` to identify the system (laptop: `work`, desktop: `main`/personal), and sync shared changes across both branches.
