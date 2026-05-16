---
name: ci-commit
description: Create atomic git commits for session changes without user interaction
---

## What I do
- Review conversation history and understand what was accomplished
- Run `git status` and `git diff` to understand modifications
- Group related changes into logical commits
- Add specific files (never `-A` or `.`)
- Create commits with clear, imperative messages
- Never commit the `thoughts/` directory or dummy/generated files
- Never ask for user feedback

## When to use me
Use this when you want to auto-commit all session changes without stopping for approval. Ideal for CI workflows or when you trust the agent's judgment on commit granularity.
