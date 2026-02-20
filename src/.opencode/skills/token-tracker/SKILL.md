---
name: token-tracker
description: Monitors context window usage and prevents token overflow during agent orchestration
compatibility: opencode
---

## What I do
- Calculate token count of context snippets before passing to agents
- Warn when prompts exceed 80% of model's context limit
- Suggest context compression strategies when approaching limits

## When to use me
Use this when running complex multi-agent workflows to prevent context overflow.
