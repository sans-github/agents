# Rule: Progress Tracking for Multi-Phase Work

`workflow/plan-with-human-gates.md` is the single source of truth for both human milestone gates and phase progress. It is progressively filled by EM as decisions are made.

For any task that follows a phased workflow, maintain `plan-with-human-gates.md` throughout execution.

## Setup

`plan-with-human-gates.md` is seeded at kickoff with initial steps and human gates. EM adds detailed implementation steps progressively -- after arch engagement is decided, after detailed design, etc. Do not begin implementation work until the relevant steps exist in the plan.

## During execution

- Check off each step immediately when its output is confirmed present and correct -- not when work starts.
- Never mark a step complete based on memory or assumption. Verify by checking the actual artifact, file, or commit.
- For steps that produce a file artifact: write the relative path as `→ path/to/artifact.md` in the step line before checking it off. Do not check off until the file exists at that path.
- Do not batch checkoffs. Mark steps one at a time as they complete.
- When the orchestrator reaches the end of the list, stop and wait -- EM will add the next batch of steps.

## On resume (interrupted session)

1. Read `plan-with-human-gates.md` first.
2. Find the last checked step.
3. Verify that step's output actually exists (file, artifact, commit). If it does not, uncheck it and redo it.
4. Continue from the first unchecked step.

## Format

Every step must include a done condition so the orchestrator can verify completion, not infer it.

```markdown
## Kickoff

1. [x] **PM:** review PRD with human, confirm scope → `product-specs/prd.md` -- done when: human approves verbally
2. [x] 👤 **HUMAN:** review and approve PRD -- done when: human confirms
3. [x] **DESIGNER:** produce mocks → `generated-docs/mocks/login-flow.html` -- done when: mocks present and PM satisfied
4. [ ] **ARCH:** produce HLD → `generated-docs/hld.md` -- done when: EM approves
```

The `→ path` on a checked step is the confirmed artifact link -- written by the agent when it checks off, not at plan creation. For steps that produce multiple files, list them all: `→ path/a.md, path/b.html`.

Skipped steps (e.g. out of scope for current delivery phase) should be marked with a note rather than left blank:

```markdown
5. [ ] **SDET:** X -- SKIPPED (Phase 1: SDET inactive)
```
