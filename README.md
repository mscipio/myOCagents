# OpenCode Agent Suit

A production-ready multi-agent orchestration framework for AI-driven software development.

## What's Included

- **7 Specialized Agents**: Orchestrator, Engineer, Task Manager, Guardian, Librarian, Beagle, Sentinel, Technical Writer
- **7 Commands**: init-context, sync-context, detect-drift, generate-release, explain-context, revert-milestone
- **4 Skills**: TokenTracker, AST-Analyzer, CoverageReporter, ParallelExec
- **4 Lifecycle Hooks**: pre-change, post-checkout, post-sync, on-error

## Quick Install

```bash
# Run in your project directory
curl -sL https://raw.githubusercontent.com/mscipio/opencode-agentsuit/main/install.sh | bash
```

Or manual:

```bash
# Clone this repo
git clone https://github.com/mscipio/opencode-agentsuit.git .opencode_tmp

# Extract .opencode folder and config to current directory
mv .opencode_tmp/src/.opencode .
mv .opencode_tmp/src/opencode.json .

# Clean up
rm -rf .opencode_tmp
```

## Features

- Context-first architecture with drift detection
- Human-in-the-loop approval gates
- Parallel agent execution
- Security auditing (Sentinel)
- Coverage enforcement (Guardian)
- Semantic commits & changelog generation

## Requirements

- Node.js 18+
- Git
- OpenCode CLI

## License

MIT
