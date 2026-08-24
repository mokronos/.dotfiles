# AGENTS.md

- Keep all config changes synced with ~/.dotfiles.
- After any change, commit and push it from ~/.dotfiles.
- Cherry-pick general config changes relevant to the work machine onto the work branch.
    - Work machine: Windows + WSL; Linux tooling applies. Arch/Omarchy-specific config does not.
    - Main machine: Arch/Omarchy. WSL specific hacks/fixes do not apply.
- When modifying work, use a separate worktree to avoid breaking live symlinked configs.
