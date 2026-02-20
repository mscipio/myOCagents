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
curl -sL https://raw.githubusercontent.com/YOUR_USERNAME/opencode-agentsuit/main/install.sh | bash
```

Or manual:

```bash
# Clone this repo
git clone https://github.com/YOUR_USERNAME/opencode-agentsuit.git .opencode_tmp

# Move to .opencode
rm -rf .opencode
mv .opencode_tmp .opencode

# Install dependencies
cd .opencode && npm install
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
