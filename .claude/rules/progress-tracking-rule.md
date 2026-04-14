# Rule: Progress Tracking for Multi-Phase Work

For any task that follows a phased workflow, maintain a progress tracker throughout execution.

## Setup

Before starting any work, create `workflow/implementation-plan-tracker.md` by listing every step from `workflow/implementation-plan.md` as an unchecked checkbox. The tracker derives from the implementation plan -- not the kickoff plan. Do not create the tracker until `implementation-plan.md` exists and is approved.

## During execution

- Check off each step immediately when its output is confirmed present and correct -- not when work starts.
- Never mark a step complete based on memory or assumption. Verify by checking the actual artifact, file, or commit.
- Do not batch checkoffs. Mark steps one at a time as they complete.

## On resume (interrupted session)

1. Read `implementation-plan-tracker.md` first.
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
