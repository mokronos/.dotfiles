# AGENTS.md

- Keep all config changes synced with ~/.dotfiles.
- After any change, commit and push it from ~/.dotfiles.
- When modifying config, use a separate worktree to avoid breaking live symlinked configs.
- Keep changes specific to a machine or work/personal context on the corresponding branch, and sync generally applicable changes across both; check `/sys/class/dmi/id/chassis_type` to identify the system (laptop: `work`, desktop: `main`/personal).
