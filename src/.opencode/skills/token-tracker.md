# Skill: TokenTracker
## Role: Context Window & Cost Management

### I. DESCRIPTION
Monitors the payload size of parallel subagent requests. 

### II. LOGIC
1. Calculate token count of the current `context_snippet` + `file_content` before passing it to an `Engineer`.
2. If the prompt exceeds 80% of the model's context limit, interrupt the `Orchestrator` with a `TOKEN_WARNING`.
3. Force the `Orchestrator` to call `summarize_module` to compress the context before proceeding.