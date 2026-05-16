---
name: commit
description: Create git commits with user approval and no AI attribution
---

## What I do
- Review conversation history and understand what was accomplished
- Run `git status` and `git diff` to understand modifications
- Plan commits with proposed messages and file lists
- Present the commit plan to the user for approval
- Execute with `git add` for specific files (never `-A` or `.`)
- Show results with `git log --oneline`
- Never add co-author or AI attribution lines
- Write commit messages as if the user wrote them

## When to use me
Use this when you want the agent to propose a commit strategy and get your sign-off before making changes. Best for when you want control over commit organization and message content.
