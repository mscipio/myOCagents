# AGENTS.md - OpenCode Agent Suit

This file provides guidelines for agentic coding agents operating in this repository.

## Project Overview

This is the **OpenCode Agent Suit** - a production-ready multi-agent orchestration framework for AI-driven software development. The repository contains:
- **10 Specialized Agents**: Orchestrator, Engineer, TestEngineer, CodeReviewer, Task Manager, Guardian, Librarian, Sentinel, Technical Writer, Beagle
- **7 Commands**: init-context, sync-context, detect-drift, generate-release, explain-context, revert-milestone
- **4 Skills**: TokenTracker, AST-Analyzer, CoverageReporter, ParallelExec
- **4 Lifecycle Hooks**: pre-change, post-checkout, post-sync, on-error

This is a **template/configuration repository** - the "code" is primarily markdown files (agents, skills, commands, hooks), not executable code.

---

## Agent Workflow

The Orchestrator follows this workflow for every user request:

```
User Request
     ↓
Phase 0: Task-Manager (decompose into DAG)
     ↓
Phase 1: Librarian (verify context)
     ↓
Phase 2: User Approval (plan)
     ↓
Phase 3: Engineer + TestEngineer (implementation)
     ↓
Phase 3b: Sentinel (security audit) ← MANDATORY
     ↓
Phase 4: CodeReviewer (quality review)
     ↓
Phase 5: Guardian (coverage + commit)
     ↓
Librarian (sync context)
```

### Agent Responsibilities

| Agent | Mode | Role | Can Invoke Directly? |
|-------|------|------|---------------------|
| **Orchestrator** | primary | Strategic lead - manages workflow, approval gates | ✅ Yes |
| **Sentinel** | primary | Security vulnerability scanning | ✅ Yes |
| **CodeReviewer** | primary | Quality review, patterns, performance | ✅ Yes |
| **TestEngineer** | primary | Test writing (unit, integration, e2e) | ✅ Yes |
| **TechnicalWriter** | primary | Documentation | ✅ Yes |
| **Beagle** | primary | Research, dependency tracing | ✅ Yes |
| **Task-Manager** | subagent | Decompose tasks into atomic execution DAGs | ❌ Via Orchestrator |
| **Librarian** | subagent | Context management, drift detection | ❌ Via Orchestrator |
| **Engineer** | subagent | Code implementation with TDD | ❌ Via Orchestrator |
| **Guardian** | subagent | Coverage verification, semantic commits | ❌ Via Orchestrator |

### Approval Gates

1. **Plan Approval** - User must approve task decomposition before execution
2. **Commit Approval** - User must approve final changes before git commit

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

### Validation (Manual Checks)

- **YAML Frontmatter**: Validate YAML syntax in all agent/skill files
- **Markdown Links**: Verify internal links point to existing files
- **File Structure**: Ensure consistent directory layout

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

**Rules:**
- Frontmatter MUST use `---` delimiters (not `...`)
- Fields must be lowercase
- Boolean values use `true`/`false` (not `yes`/`no`)
- Tools and permissions should be listed explicitly

### 2.2 Markdown Structure

#### File Headers
```markdown
# Agent: [Agent Name]
## Role: [One-line role description]
## Version: X.Y.Z
## Source Inspiration: [External sources if applicable]

### I. IDENTITY & MISSION
[Detailed description]

---

### II. ARCHITECTURAL PROTOCOLS
[Protocol sections]

---

### III. OPERATIONAL WORKFLOW
[Workflow sections with phases]
```

#### Section Separators
- Use `---` (horizontal rule) to separate major sections
- Use `###` for subsections
- Use `##` for major headings within files

### 2.3 Naming Conventions

| Component | Convention | Example |
|-----------|------------|---------|
| Agents | kebab-case with `-agent` suffix | `orchestrator.md`, `task-manager.md` |
| Skills | kebab-case | `token-tracker.md`, `ast-analyzer.md` |
| Commands | kebab-case | `init-context.md`, `sync-context.md` |
| Hooks | kebab-case | `pre-change.md`, `post-checkout.md` |
| Context files | kebab-case | `map.md`, `tech-stack.md`, `progress.md` |

### 2.4 Directory Structure

```
.opencode/
├── agents/           # Agent definitions (one per file)
│   ├── orchestrator.md
│   ├── engineer.md
│   └── ...
├── skills/           # Skill definitions
│   ├── token-tracker/
│   │   └── SKILL.md
│   └── token-tracker.md
├── commands/         # Command definitions
│   └── init-context.md
├── hooks/            # Lifecycle hooks
│   └── pre-change.md
└── context/         # Auto-generated (NOT committed)
    ├── map.md
    └── tech_stack.md
```

### 2.5 Error Handling Guidelines

From the Engineer agent patterns:

1. **Always use try/catch**: Every async operation must have error handling
2. **No silent failures**: Log errors explicitly
3. **Graceful degradation**: Provide fallback behaviors when possible
4. **Error propagation**: Raise errors to appropriate handlers

```markdown
### Error Handling Protocol
- **Subagent Failure:** If an Engineer fails, do not retry blindly. Request deeper analysis.
- **Merge Conflicts:** Manually resolve in reasoning space before final output.
- **Context Drift:** Stop all agents, inform user, run sync-context before continuing.
```

### 2.6 Type Safety

When documenting type requirements:

- **TypeScript**: Use strict typing, avoid `any`
- **Python**: Use type hints, prefer `Optional[T]` over `Union[T, None]`
- **Go**: Use explicit types, avoid `interface{}`

### 2.7 Documentation Patterns

#### Agent Documentation Template
```markdown
---
description: [What this agent does]
mode: primary|subagent
tools:
  [list of allowed tools]
permission:
  [edit: ask|yes|no]
---

# Agent: [Name]
## Role: [Role description]
## Version: X.Y.Z

### I. IDENTITY & MISSION
[Detailed mission statement]

---

### II. ARCHITECTURAL PROTOCOLS
[Protocols the agent follows]

---

### III. OPERATIONAL WORKFLOW
[Phase-by-phase workflow]

---

### IV. SYSTEM CAPABILITIES & TOOL USAGE
[Available tools and how to use them]

---

### V. CHAIN-OF-THOUGHT EXAMPLES
[Real-world examples showing reasoning]
```

#### Skill Documentation Template
```markdown
---
name: skill-name
description: What this skill does
compatibility: opencode
---

## What I do
- [Capability 1]
- [Capability 2]

## When to use me
[Use case guidance]
```

### 2.8 Output Formatting

When agents submit完成任务, use this structure:

```markdown
### 🛠️ Task Completion: [Task Name]
**Scope:** [Files Modified]
**Technical Summary:** [Brief explanation]
**Tests Run:** [List of passing tests]

#### 📝 Proposed Changes (Diff):
```diff
--- a/file.ts
+++ b/file.ts
@@ -10,4 +10,5 @@
```

**Handover Note:** [Ready for audit/commit]
```

### 2.9 Version Management

- Use **Semantic Versioning** (MAJOR.MINOR.PATCH)
- Update version in file header when making breaking changes
- Document version changes in agent descriptions

---

## 3. Context Management

The `.opencode/context/` directory is **auto-generated and must NOT be committed**. It's created at runtime by the Librarian agent:

```bash
opencode init-context  # Creates context directory
opencode sync-context  # Updates context after changes
```

### Context Files
- `map.md` - Codebase file structure with SHA-256 hashes
- `tech_stack.md` - Detected frameworks and dependencies
- `progress.md` - Session milestones and task history

---

## 4. Key Patterns from Existing Agents

### Parallel Delegation
The Orchestrator should decompose tasks into independent sub-tasks and spawn multiple Engineer subagents using parallel delegation where possible.

### Atomic Scope (Engineer)
- Only modify files explicitly listed in task assignment
- Request scope expansion if dependencies are identified
- Avoid global side effects

### Test-First Engineering
- Every feature/bug fix must have corresponding tests
- Run tests before submission to ensure no regressions

### Human-in-the-Loop
- Present "Proposed Change Plan" with diff before execution
- Wait for explicit user consent ("Yes", "Proceed", "LGTM")
- Never silently write to source code

---

## 5. Git Operations

- **Engineer subagents**: NO git operations allowed
- **Orchestrator**: Handles approval and delegation only
- **Guardian**: Quality audits and coverage reporting
- **Commit workflow**: Engineer → Guardian audit → Orchestrator approval → Commit

---

## Summary

This repository follows markdown-based conventions for agentic workflows. Key principles:
1. **YAML frontmatter required** on all agent/skill files
2. **Consistent section structure** with `---` separators
3. **No `.opencode/context/` committed** - auto-generated
4. **Strict approval gates** - no silent writes
5. **TDD approach** - tests before implementation
6. **Atomic, scoped changes** - isolated modifications
