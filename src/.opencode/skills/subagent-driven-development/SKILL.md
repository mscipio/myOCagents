---
name: subagent-driven-development
description: Use when executing implementation plans with independent tasks - dispatches fresh subagent per task with two-stage review
---

# Subagent-Driven Development

Execute plan by dispatching fresh subagent per task, with two-stage review after each: spec compliance review first, then code quality review.

**Core principle:** Fresh subagent per task + two-stage review (spec then quality) = high quality, fast iteration

## When to Use

**Use when:**
- Have implementation plan from `writing-plans` skill
- Tasks are mostly independent
- Want to stay in current session

**vs. Manual Execution:**
- Faster iteration (no human-in-loop between tasks)
- Fresh context per task (no context pollution)
- Automatic review checkpoints

## Prerequisites

Before starting:
1. **Worktree created** - Use `using-git-worktrees` skill first
2. **Plan loaded** - Read plan from `.context/plans/YYYY-MM-DD-<feature>.md`
3. **Tests passing** - Verify clean baseline

## The Process

```
Read plan, extract all tasks
        ↓
Create todo list with all tasks
        ↓
┌─────────────────────────────────────┐
│ For each task:                      │
│                                     │
│ 1. Dispatch implementer subagent    │
│    - Provide full task text         │
│    - Provide necessary context      │
│                                     │
│ 2. Implementer implements, tests,   │
│    commits, self-reviews            │
│                                     │
│ 3. Dispatch spec reviewer subagent  │
│    - Verify matches requirements    │
│    - Check for missing/extra work   │
│                                     │
│ 4. If spec issues:                  │
│    - Implementer fixes              │
│    - Re-review                      │
│                                     │
│ 5. Dispatch quality reviewer        │
│    - Check code quality             │
│    - Check test coverage            │
│                                     │
│ 6. If quality issues:               │
│    - Implementer fixes              │
│    - Re-review                      │
│                                     │
│ 7. Mark task complete               │
│                                     │
└─────────────────────────────────────┘
        ↓
All tasks complete?
        ↓
Final review of entire implementation
        ↓
Use finishing-a-development-branch skill
```

## Two-Stage Review

### Stage 1: Spec Compliance Review

**Questions to answer:**
- Did we build what was requested?
- Are all requirements met?
- Is anything missing?
- Is anything extra (not requested)?

**Outcome:**
- ✅ Spec compliant → Proceed to quality review
- ❌ Issues found → Implementer fixes, re-review

### Stage 2: Code Quality Review

**Questions to answer:**
- Is the code well-structured?
- Are tests comprehensive?
- Is error handling adequate?
- Are there code smells?

**Outcome:**
- ✅ Quality approved → Mark task complete
- ❌ Issues found → Implementer fixes, re-review

## Implementer Subagent Prompt Template

When dispatching implementer:

```markdown
You are implementing Task N from the implementation plan.

**Task:** [Full task text from plan]

**Context:**
- Project: [Brief description]
- Related files: [List relevant files]
- Dependencies: [What's already done]

**Requirements:**
1. Follow TDD: Write failing test first
2. Implement minimal code to pass
3. Run tests to verify
4. Commit with message from plan
5. Self-review your work

**Files to modify:**
- [Exact file paths from plan]

Begin implementation.
```

## Spec Reviewer Prompt Template

```markdown
Review this implementation for spec compliance.

**Task Requirements:** [Full task text]

**What was implemented:**
- [Summary of changes]

**Git diff:**
[Show the diff]

**Questions:**
1. Are all requirements from the task met?
2. Is anything missing?
3. Is anything extra (not requested)?

Provide clear assessment: ✅ Spec compliant OR ❌ Issues: [list]
```

## Quality Reviewer Prompt Template

```markdown
Review this implementation for code quality.

**Changes made:**
- [Summary]

**Git diff:**
[Show the diff]

**Review criteria:**
- Code structure and organization
- Test coverage and quality
- Error handling
- Naming and readability
- Potential bugs or issues

Provide assessment with severity:
- Critical: Must fix before proceeding
- Important: Should fix soon
- Minor: Nice to have
```

## Example Workflow

```
You: I'm using Subagent-Driven Development to execute this plan.

[Read plan: .context/plans/auth-plan.md]
[Extract 5 tasks with full text]
[Create todo list]

Task 1: Password Hashing

[Dispatch implementer with Task 1 text + context]

Implementer: "Implementing password hashing..."
[Later] Implementer:
  - Created password.service.ts
  - Added tests, 3/3 passing
  - Self-review: Looks good
  - Committed

[Dispatch spec reviewer]
Spec reviewer: ✅ Spec compliant - all requirements met

[Dispatch quality reviewer]
Quality reviewer: 
  Strengths: Clean implementation, good tests
  Issues (Minor): Could add salt rounds config
  Assessment: Approved

[Mark Task 1 complete]

Task 2: JWT Token Generation

[Continue with Task 2...]

...

[After all tasks]
[Dispatch final reviewer]
Final reviewer: All requirements met, ready to merge

[Use finishing-a-development-branch skill]
```

## Advantages

**vs. Manual execution:**
- Subagents follow TDD naturally
- Fresh context per task (no confusion)
- Review checkpoints automatic
- Questions surfaced before work begins

**Quality gates:**
- Self-review catches issues before handoff
- Two-stage review: spec compliance, then code quality
- Review loops ensure fixes actually work
- Spec compliance prevents over/under-building

## Red Flags

**Never:**
- Start implementation on main/master branch
- Skip reviews (spec compliance OR code quality)
- Proceed with unfixed issues
- Dispatch multiple implementation subagents in parallel (conflicts)
- Accept "close enough" on spec compliance
- Skip review loops
- Start code quality review before spec compliance is ✅

**If subagent asks questions:**
- Answer clearly and completely
- Provide additional context if needed
- Don't rush them into implementation

**If reviewer finds issues:**
- Implementer fixes them
- Reviewer reviews again
- Repeat until approved

**If subagent fails task:**
- Dispatch fix subagent with specific instructions
- Don't try to fix manually (context pollution)

## Integration

**Required workflow skills:**
- `using-git-worktrees` - REQUIRED: Set up isolated workspace before starting
- `writing-plans` - Creates the plan this skill executes
- `tdd-workflow` - Subagents follow TDD for each task
- `finishing-a-development-branch` - Complete development after all tasks

**Alternative workflow:**
- Manual execution - User works through tasks themselves
