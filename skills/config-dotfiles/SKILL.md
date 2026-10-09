---
name: config-dotfiles
description: Use this skill whenever changing, inspecting, troubleshooting, installing, or documenting configuration for the user's computers or personal development environment, including operating systems, shells, terminals, desktop environments, editors, and dotfiles. Do not use it when changing a software project's own configuration, such as its formatter, build, CI, runtime, deployment, or app settings, even if the project is in a repository.
---

# Computer and environment configuration

Use `~/.dotfiles` as the source of truth for durable computer and environment configuration. Keep changes machine-aware and avoid editing live symlinked configuration directly.

## Choose the right scope

- Determine which computer or context the request targets. If unclear, check `/sys/class/dmi/id/chassis_type`: laptops use the `work` branch; desktops use `main` for personal configuration.
- Keep machine- or work/personal-specific changes on the corresponding branch.
- Sync generally applicable configuration changes across both branches.
- Keep work-machine changes appropriate to that machine, and personal-machine changes appropriate to the personal machine.

## Make and sync changes

1. Inspect the dotfiles repository and its status before editing. Preserve unrelated local changes.
2. Make changes in a separate Git worktree so live symlinked configuration is not disturbed.
3. Keep the resulting configuration change synced with `~/.dotfiles`.
4. Commit and push the change from the dotfiles repository.
5. For generally applicable changes, cherry-pick the commit onto the other branch and push it there too. Keep machine-specific changes on their target branch only.

This skill is for the user's computer and environment configuration. If a setting belongs to an individual software project, follow that project's own instructions instead.
