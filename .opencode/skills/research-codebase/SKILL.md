---
name: research-codebase
description: Conduct comprehensive codebase research and document findings in thoughts/
---

## What I do
- Read provided files completely before spawning sub-tasks
- Decompose research questions into composable areas
- Spawn parallel agents (codebase-locator, codebase-analyzer, codebase-pattern-finder, thoughts-locator)
- Synthesize findings with concrete file:line references
- Write research documents to `thoughts/shared/research/YYYY-MM-DD-ENG-XXXX-description.md`
- Include YAML frontmatter with date, researcher, git commit, branch
- Add GitHub permalinks when on main/master or pushed branches
- Handle follow-up questions by appending to the same document
- Document what exists without suggesting improvements

## When to use me
Use this when you need to understand how part of the codebase works. Provide a research question and the agent will explore the codebase thoroughly, documenting findings in a research document.
