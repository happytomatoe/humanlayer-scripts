---
name: create-worktree
description: Create git worktree and launch implementation session for a plan
---

## What I do
- Create a new git worktree with the specified branch name
- Determine branch name, plan file path, and launch prompt
- Use relative paths (the `thoughts/` directory is synced between worktrees)
- Confirm details with the user before creating
- Present the planned launch command for approval

## When to use me
Use this when you want to set up an isolated worktree environment to implement a plan. Creates the worktree, prepares the launch command with `/implement_plan`, and optionally chains to commit and PR creation.
