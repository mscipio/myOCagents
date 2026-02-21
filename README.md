# OpenCode Agent Suit

A production-ready multi-agent orchestration framework for AI-driven software development.

## What's Included

- **10 Specialized Agents**: Orchestrator, Engineer, TestEngineer, CodeReviewer, TaskManager, Guardian, Librarian, Beagle, Sentinel, TechnicalWriter
- **20 Commands**: init-context, sync-context, detect-drift, explain-context, revert-milestone, generate-release, security-scan, code-review, run-tests, refactor, debug, explain, migrate, audit, chores, docs, tests, commit, push, branch
- **15 Skills**: token-tracker, ast-analyzer, coverage-reporter, parallel-exec, security-scanner, code-analyzer, doc-generator, tdd-workflow, git-helper, git-release, debug-workflow, refactor-workflow, spec-workflow, commit-msg, atdd
- **6 Lifecycle Hooks**: pre-change, post-change, pre-commit, post-checkout, post-sync, on-error

## Quick Install

```bash
# Run in your project directory
curl -sL https://raw.githubusercontent.com/mscipio/opencode-agentsuit/main/install.sh | bash
```

Or manual:

```bash
# Clone this repo
git clone https://github.com/mscipio/opencode-agentsuit.git .opencode_tmp

# Extract .opencode folder, config, and AGENTS.md to current directory
mv .opencode_tmp/src/.opencode .
mv .opencode_tmp/src/opencode.json .
mv .opencode_tmp/src/AGENTS.md .

# Clean up
rm -rf .opencode_tmp
```

## Features

- Context-first architecture with drift detection
- Human-in-the-loop approval gates
- Parallel agent execution
- Security auditing (Sentinel)
- Code quality review (CodeReviewer)
- Test generation (TestEngineer)
- Coverage enforcement (Guardian)
- Semantic commits & changelog generation
- Git push & branch management (Orchestrator)
- Documentation generation (TechnicalWriter)
- Research & exploration (Beagle)

## Workflow

```
User Request
     ↓
Orchestrator (primary agent)
     ↓
Phase 0: Task-Manager → decomposes into DAG
     ↓
Phase 1: Librarian → verifies context
     ↓
Phase 2: User approves plan
     ↓
Phase 3: Engineer + TestEngineer → implementation
     ↓
Phase 3b: Sentinel → security audit (MANDATORY)
     ↓
Phase 4: CodeReviewer → quality review
     ↓
Phase 5: Guardian → coverage + commit
     ↓
Orchestrator → git push
     ↓
Librarian → sync context
```

## Commands

| Category | Commands |
|----------|----------|
| Context | init-context, sync-context, detect-drift, explain-context, revert-milestone |
| Quality | security-scan, audit, code-review |
| Git | commit (Guardian), push (Orchestrator), branch (Orchestrator) |
| Development | refactor, debug, migrate |
| Test | run-tests, tests |
| Docs | docs |
| Release | generate-release, chores |
| Research | explain |

## Requirements

- Node.js 18+
- Git
- OpenCode CLI

## License

MIT
