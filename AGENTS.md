# Agent Instructions

This is a meta-repository of AI agent skills and configurations for structured software development workflows. It provides reusable skills for Claude Code, GitHub Copilot, and OpenCode.

## Setup

```bash
just setup
```

Symlinks all skills from `.agents/skills/` into `~/.agents/skills/` (global) and `.claude/skills/` (project-level). Run once after cloning.

## Repository Layout

| Path | Purpose |
|------|---------|
| `.agents/skills/` | Source of truth for all 10 reusable skills |
| `.claude/agents/` | Claude Code sub-agent definitions |
| `.github/agents/` | GitHub Copilot agent definitions |
| `.opencode/` | OpenCode agent and command definitions |

## Skills Reference

Each skill lives at `.agents/skills/<name>/SKILL.md`. Invoke via `/.<name>` or `/<name>` depending on the tool.

| Skill | When to use |
|-------|-------------|
| `commit` | Commit changes with user approval, no Claude attribution |
| `ci_commit` | Same as commit but automated (no approval step) |
| `create_plan` | Plan a feature/fix — spawns parallel research agents, produces structured plan |
| `iterate_plan` | Refine an existing plan based on feedback |
| `implement_plan` | Execute an approved plan phase by phase |
| `validate_plan` | Verify a completed implementation matches its plan |
| `create_handoff` | Hand off in-progress work to another agent/session |
| `resume_handoff` | Resume work from a handoff document |
| `create_worktree` | Create a git worktree for isolated feature work |
| `research_codebase` | Document how a system works (descriptive, no critique) |

## File Naming Conventions

- Plans / research docs: `YYYY-MM-DD-ENG-XXXX-description.md`
- Handoffs: `YYYY-MM-DD_HH-MM-SS_ENG-XXXX_description.md`
- All placed under `thoughts/shared/` (plans/, handoffs/, research/)

## Key Principles

- **Read files fully** — never use limit/offset on plan or skill files
- **Parallel research** — spawn sub-agents concurrently where possible
- **Describe, don't critique** — research agents document what IS
- **Specific references** — always include `file:line` in code citations
- **No open questions in final plans** — resolve all decisions before marking a plan ready
