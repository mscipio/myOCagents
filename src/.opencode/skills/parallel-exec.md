# Skill: ParallelExec
## Role: Concurrent Task Dispatcher
## Source: Inspired by VoltAgent

### I. DESCRIPTION
Allows the Orchestrator to instantiate multiple sub-agent environments simultaneously. It manages the lifecycle of these "child processes" and aggregates their stdout/stderr into a unified feedback loop.

### II. EXECUTION LOGIC
1. **Isolation:** Creates a temporary environment for each sub-agent (Engineer A, Engineer B, etc.).
2. **Resource Allocation:** Distributes the specific file-scope and context-snippets to each sub-agent.
3. **Synchronization:** Waits for all spawned agents to reach a "Submission" state.
4. **Conflict Resolution:** If two agents modify the same file (detected via git diff), it halts and prompts the Orchestrator to perform a manual merge.

### III. USAGE EXAMPLE
`parallel_exec([{agent: "Engineer", task: "update-api"}, {agent: "Engineer", task: "update-ui"}])`