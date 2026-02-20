# Skill: AST-Analyzer
## Role: Deterministic Code Parsing

### I. DESCRIPTION
Wraps a tool like Tree-sitter to parse source code into an Abstract Syntax Tree. This allows agents to confidently extract variable names, exported classes, and function signatures without relying on fragile regex or LLM hallucination.

### II. USAGE
`ast_analyze({ file: "src/auth.ts", extract: ["exports", "imports"] })`

### III. CONSUMERS
- **Librarian:** Uses this to build the `map.md` with 100% accuracy.
- **Sentinel:** Uses this to trace where unsanitized variables are passed into secure functions.