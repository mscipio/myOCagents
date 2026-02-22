# AGENTS.md - OpenCode Agent Suit

This file provides guidelines for agentic coding agents operating in this repository.

## Project Overview

This is the **OpenCode Agent Suit** - a production-ready multi-agent orchestration framework for AI-driven software development. The repository contains:
- **10 Specialized Agents**: Orchestrator, Engineer, TestEngineer, CodeReviewer, Task Manager, Guardian, Librarian, Sentinel, Technical Writer, Beagle
- **20+ Skills**: brainstorming, tdd-workflow, systematic-debugging, writing-plans, using-git-worktrees, subagent-driven-development, finishing-a-development-branch, and more
- **17 Commands**: init-context, sync-context, detect-drift, generate-release, explain-context, revert-milestone, commit, push, branch, and more
- **6 Lifecycle Hooks**: pre-change, post-change, pre-commit, post-checkout, post-sync, on-error

This is a **template/configuration repository** - the "code" is primarily markdown files (agents, skills, commands, hooks), not executable code.

---

## Agent Workflow

The Orchestrator follows this workflow for every user request:

```
User Request
     ↓
Phase 0: Brainstorming (design exploration) ← MANDATORY FIRST
     ↓
Phase 1: Writing Plans (granular task breakdown)
     ↓
Phase 2: Git Worktrees (isolated workspace)
     ↓
Phase 3: Subagent-Driven Development (implementation with TDD)
     ↓
Phase 3b: Sentinel (security audit) ← MANDATORY
     ↓
Phase 4: CodeReviewer (two-stage review: spec → quality)
     ↓
Phase 5: Guardian (coverage + commit)
     ↓
Finishing Branch (merge/PR/cleanup)
     ↓
Librarian (sync context)
```

### Agent Responsibilities

| Agent | Mode | Role | Can Invoke Directly? |
|-------|------|------|---------------------|
| **Orchestrator** | primary | Strategic lead - manages workflow, approval gates, git push & branch management | ✅ Yes |
| **Sentinel** | primary | Security vulnerability scanning | ✅ Yes |
| **CodeReviewer** | primary | Two-stage review (spec compliance + code quality) | ✅ Yes |
| **TestEngineer** | primary | Coverage audits, edge case testing, E2E tests | ✅ Yes |
| **TechnicalWriter** | primary | Documentation | ✅ Yes |
| **Beagle** | primary | Research, dependency tracing | ✅ Yes |
| **Task-Manager** | subagent | Decompose tasks into granular 2-5 min steps | ❌ Via Orchestrator |
| **Librarian** | subagent | Context management, drift detection | ❌ Via Orchestrator |
| **Engineer** | subagent | Code implementation with TDD (owns full cycle) | ❌ Via Orchestrator |
| **Guardian** | subagent | Coverage verification, commits (local only) | ❌ Via Orchestrator |

### Approval Gates

1. **Design Approval** - User must approve design before implementation begins
2. **Plan Approval** - User must approve task decomposition before execution
3. **Commit Approval** - User must approve final changes before Guardian commits
4. **Push Approval** - User must approve before Orchestrator pushes to remote

---

## Core Skills (Workflow)

### Design-First Workflow

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `brainstorming` | Design exploration, requirements gathering | MANDATORY FIRST before any implementation |
| `writing-plans` | Create granular implementation plans | After design approval |
| `using-git-worktrees` | Create isolated workspace | Before implementation begins |
| `subagent-driven-development` | Execute plans with two-stage review | During implementation |
| `finishing-a-development-branch` | Merge/PR/cleanup workflow | After all tasks complete |

### Quality Skills

| Skill | Purpose | When to Use |
|-------|---------|-------------|
| `tdd-workflow` | Test-driven development with Iron Law | During all implementation |
| `systematic-debugging` | 4-phase root cause investigation | When encountering bugs |
| `code-analyzer` | Objective quality metrics | During code review |

### Support Skills

| Skill | Purpose |
|-------|---------|
| `parallel-exec` | Dispatch multiple sub-agents simultaneously |
| `token-tracker` | Monitor context window usage |
| `ast-analyzer` | Parse code into AST for analysis |
| `coverage-reporter` | Parse coverage reports |
| `git-helper` | Common git operations |
| `git-release` | Semantic versioning, changelog |

---

## Key Principles

### 1. Design-First (HARD-GATE)

```
NO IMPLEMENTATION WITHOUT DESIGN APPROVAL
```

Before any coding:
1. Use `brainstorming` skill to explore requirements
2. Present design to user
3. Get explicit approval
4. Save design to `docs/plans/YYYY-MM-DD-<topic>-design.md`

### 2. TDD Iron Law

```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```

Write code before the test? Delete it. Start over.

### 3. Two-Stage Review

Every code review has two stages:
1. **Spec Compliance**: Did we build what was requested?
2. **Code Quality**: Is it well-built?

### 4. Granular Tasks

Each step is ONE action (2-5 minutes):
- "Write the failing test" - step
- "Run it to make sure it fails" - step
- "Implement minimal code" - step
- "Run tests" - step
- "Commit" - step

### 5. Workspace Isolation

Use git worktrees for all feature work:
- Prevents branch pollution
- Enables parallel development
- Clean test baseline verification

---

## 1. Build, Lint, and Test Commands

Since this is a template repository, there are no traditional build commands. However, the install script handles setup:

```bash
# Install (run from project root)
curl -sL https://raw.githubusercontent.com/mscipio/opencode-agentsuit/main/install.sh | bash

# Or manual installation
git clone https://github.com/mscipio/opencode-agentsuit.git .opencode_tmp
rm -rf .opencode
mv .opencode_tmp .opencode
cd .opencode && npm install
```

### Running Context Commands

```bash
opencode init-context      # Initialize project context
opencode sync-context      # Sync context after changes
opencode detect-drift      # Check for external changes
opencode generate-release   # Prepare release
```

---

## 2. Code Style Guidelines

### 2.1 YAML Frontmatter (Required)

All agent, skill, command, and hook files MUST include YAML frontmatter:

```yaml
---
description: Brief description of what this component does
mode: primary|subagent      # For agents only
tools:                      # For agents only
  write: true
  edit: true
  bash: true
  task: true
  read: true
  glob: true
  grep: true
permission:                # For agents only
  edit: ask
  bash: ask
name: skill-name           # For skills only
compatibility: opencode    # For skills only
---
```

### 2.2 Directory Structure

```
.opencode/
├── agents/           # Agent definitions (one per file)
│   ├── orchestrator.md
│   ├── engineer.md
│   └── ...
├── skills/           # Skill definitions
│   ├── brainstorming/
│   │   └── SKILL.md
│   ├── tdd-workflow/
│   │   └── SKILL.md
│   └── ...
├── commands/         # Command definitions
│   └── init-context.md
├── hooks/            # Lifecycle hooks
│   └── pre-change.md
└── context/         # Auto-generated (NOT committed)
    ├── map.md
    └── tech_stack.md

.context/             # Project context (NOT committed)
├── map.md
├── tech_stack.md
└── progress.md

docs/plans/           # Design documents (committed)
├── 2026-02-21-feature-design.md
└── 2026-02-21-feature-plan.md

.worktrees/           # Git worktrees (NOT committed)
└── feature-branch/
```

---

## 3. Context Management

The `.context/` directory is **auto-generated and must NOT be committed**. It's created at runtime by the Librarian agent:

```bash
opencode init-context  # Creates context directory
opencode sync-context  # Updates context after changes
```

### Context Files
- `map.md` - Codebase file structure with SHA-256 hashes
- `tech_stack.md` - Detected frameworks and dependencies
- `progress.md` - Session milestones and task history

---

## 4. Design Documents

Design documents are saved to `docs/plans/` and **ARE committed** to the repository:

```markdown
# [Feature Name] Design

**Date:** YYYY-MM-DD
**Status:** Draft / Approved

## Problem Statement
## Proposed Solution
## Architecture
## Alternatives Considered
## Testing Strategy
```

---

## 5. Git Operations

- **Engineer subagents**: NO git operations allowed
- **Orchestrator**: Handles git push, branch management, worktrees
- **Guardian**: Quality audits, coverage reporting, commits (local only)
- **Commit workflow**: Engineer → CodeReviewer → Sentinel → Guardian commits → Orchestrator pushes

---

## Summary

This repository follows markdown-based conventions for agentic workflows. Key principles:

1. **Design-first** - No implementation without design approval
2. **TDD Iron Law** - No code without failing test first
3. **Two-stage review** - Spec compliance then code quality
4. **Granular tasks** - 2-5 minute steps, not 30-minute tasks
5. **Workspace isolation** - Git worktrees for all feature work
6. **Strict approval gates** - No silent writes
7. **Atomic, scoped changes** - Isolated modifications
