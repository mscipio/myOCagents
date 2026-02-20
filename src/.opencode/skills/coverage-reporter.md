# Skill: CoverageReporter
## Role: Automated Testing Auditor
## Source: Custom Integration for OpenCode

### I. DESCRIPTION
A specialized parser that reads standard coverage output formats (`lcov`, `json`, `xml`) and translates them into a "Drift/Gap Report" for the Guardian.

### II. EXECUTION LOGIC
1. **Detection:** Locates coverage files in the project root (e.g., `/coverage`).
2. **Parsing:** Extracts % of lines, functions, and branches covered.
3. **Comparison:** Compares current metrics against the `min_threshold` defined in `.opencode/config.json`.
4. **Visualization:** Generates a Markdown table highlighting "uncovered" lines in the newly modified files.

### III. OUTPUT
A Markdown-formatted summary of the test health, specifically focusing on the delta created by the current task.