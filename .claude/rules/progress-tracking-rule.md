# Rule: Progress Tracking for Multi-Phase Work

For any task that follows a phased workflow, maintain a progress tracker throughout execution.

## Setup

Before starting any work, create a `phases-checklist.md` file (location: alongside the workflow document, e.g. `workflow/phases-checklist.md`). Populate it by listing every step from the workflow as an unchecked checkbox.

## During execution

- Check off each step immediately when its output is confirmed present and correct -- not when work starts.
- Never mark a step complete based on memory or assumption. Verify by checking the actual artifact, file, or commit.
- Do not batch checkoffs. Mark steps one at a time as they complete.

## On resume (interrupted session)

1. Read `phases-checklist.md` first.
2. Find the last checked step.
3. Verify that step's output actually exists (file, artifact, commit). If it does not, uncheck it and redo it.
4. Continue from the first unchecked step.

## Format

```markdown
## Phase Name

- [x] 1. Step description
- [x] 2. Step description
- [ ] 3. Step description
```

Skipped steps (e.g. out of scope for current delivery phase) should be marked with a note rather than left blank:

```markdown
- [ ] 5. SDET does X -- SKIPPED (Phase 1: SDET inactive)
```
