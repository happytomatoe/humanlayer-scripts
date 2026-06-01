---
name: create_worktree
description: >
  Create a git worktree and launch an implementation session for a plan.
  Use when starting implementation of a Linear ticket in an isolated worktree.
---

# Create Worktree

You are tasked with setting up a worktree for implementation and launching an implementation session.

## Process:

### 1. Set up worktree for implementation:
Read `hack/create_worktree.sh` and create a new worktree with the Linear branch name:
```
./hack/create_worktree.sh ENG-XXXX BRANCH_NAME
```

### 2. Determine required data:
- Branch name
- Path to plan file (use relative path only)
- Launch prompt
- Command to run

**IMPORTANT PATH USAGE:**
- The thoughts/ directory is synced between the main repo and worktrees
- Always use ONLY the relative path starting with `thoughts/shared/...` without any directory prefix
- Example: `thoughts/shared/plans/fix-mcp-keepalive-proper.md` (not the full absolute path)
- This works because thoughts are synced and accessible from the worktree

### 3. Confirm with the user by sending a message to the Human:

```
based on the input, I plan to create a worktree with the following details:

worktree path: ~/wt/humanlayer/ENG-XXXX
branch name: BRANCH_NAME
path to plan file: $FILEPATH
launch prompt:

    /implement_plan at $FILEPATH and when you are done implementing and all tests pass, read ./claude/commands/commit.md and create a commit, then read ./claude/commands/describe_pr.md and create a PR, then add a comment to the Linear ticket with the PR link

command to run:

    humanlayer launch --model opus -w ~/wt/humanlayer/ENG-XXXX "/implement_plan at $FILEPATH and when you are done implementing and all tests pass, read ./claude/commands/commit.md and create a commit, then read ./claude/commands/describe_pr.md and create a PR, then add a comment to the Linear ticket with the PR link"
```

Incorporate any user feedback, then:

### 4. Launch implementation session:
```
humanlayer launch --model opus -w ~/wt/humanlayer/ENG-XXXX "/implement_plan at $FILEPATH and when you are done implementing and all tests pass, read ./claude/commands/commit.md and create a commit, then read ./claude/commands/describe_pr.md and create a PR, then add a comment to the Linear ticket with the PR link"
```
