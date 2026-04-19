# Kickoff Prompt

> Fill in the variable below, then tell Claude: "Read and execute `.claude/template/kickoff-prompt.md`."

**Feature folder:** `projects/[YYYYMMDD-feature-name]`

---

## Required reading

Read these before doing anything:

1. `CLAUDE.md` (if present) -- existing software stack, conventions, project structure.
2. `.claude/agents-guide.md` -- agent team orientation, collaboration model, rules. The project config overrides where they differ.
3. `.claude/tech-config.md` -- file locations, naming conventions, tooling choices.
4. `[feature-folder]/workflow/feature-workflow-config.md` -- active agents, skipped phases, overrides.
5. `[feature-folder]/product-specs/prd.md` -- the feature PRD.

---

## Produce the kickoff plan

Write `[feature-folder]/workflow/kickoff-plan.md` with the sections below.

Emoji conventions -- use inline on the heading, row, or bullet where the action is needed:
- 👀 Human must review and explicitly confirm before work proceeds
- ❓ Human input is missing and required -- agents cannot proceed without it
- 👤 Human gate -- human must approve before downstream work is unblocked

### 1. What I understood

Start with a one-paragraph big picture: what will be built and how the pieces fit together. Then summarize the PRD and project config in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

**Folder structure check:** Verify the feature folder contains:
- `[feature-folder]/workflow/feature-workflow-config.md`
- `[feature-folder]/product-specs/prd.md`
- `[feature-folder]/generated-docs/mocks/`

If any are missing, stop and tell the human exactly what is missing.

**Input quality check:** Flag any of:
- Unfilled placeholders (`[YYYYMMDD-feature-name]`, `TODO`, `TBD`, template defaults)
- Sections untouched or still containing template defaults
- Content in `feature-workflow-config.md` or `prd.md` that contradicts the project description
- Sparse or vague entries (e.g. "active agents: all" with no rationale, one-line PRD)
- A phase in `## Project phases` marked `[ ]` whose role is absent from `## Active agents` -- contradiction, must be resolved before work begins

Do not proceed if critical inputs are missing or stale. Surface them and wait for the human.

**Risks and unknowns:** Anything that could slow the project down: unclear requirements, missing design decisions, external dependencies, integration risks with existing code, or anything needing resolution before work starts. If `tech-config.md` has changed since the last feature (or this feature requires a change), assess the impact: what changed, which parts of the codebase are affected, risk level with reasoning, extent of refactor, and whether it could introduce regressions. Do not proceed past tech-config risks without explicit human sign-off.

**Out of scope:** Explicitly state what is NOT being built, based on the project config and PRD.

**Software stack:** Inspect `src/` to determine whether an existing stack is in place. If a stack exists, confirm it and list the key technologies per layer. If no stack exists, select the minimum subset from the Tech stack section of `tech-config.md` that covers the project requirements per layer -- do not default to the full list. Choosing a lighter option already on the list does not require Arch approval. Arch approval is required only when adopting an unlisted technology -- surface the concern regardless. If anything in the PRD cannot be addressed with the current or selected stack, flag it explicitly. Flag any mismatch between stack weight and project scope: what is too broad, unnecessary, missing, or potentially wrong; why it is a concern; and a concrete alternative with rationale (e.g. "consider Zustand instead of Redux Toolkit for a single-page app with no complex shared state"). Prefer proven, widely adopted libraries. Prefer the smallest stack that covers the requirements. Do not silently confirm if the scope is small or any layer looks mismatched.

### 2. Open questions

Numbered list of questions that need my answers before agents can proceed. Do not make assumptions.

### 3. Next step

One sentence only. State exactly what happens after I approve: who does what, and what artifact they produce. Must match the first unchecked step in `plan-with-human-gates.md`.

Example: "Once approved, Designer produces mocks for `[feature-folder]/generated-docs/mocks/` before any engineering work begins."

---

## After approval

Do not begin any work until I have reviewed and approved the kickoff plan.

### When I approve the kickoff plan:

1. Write `Status: Approved — Human` and `Approved: YYYY-MM-DD` at the top of `kickoff-plan.md`.

2. Seed `[feature-folder]/workflow/plan-with-human-gates.md` from `## Project phases` in `feature-workflow-config.md`:
   - Work through each phase in order.
   - Phase `[x]`: mark all its steps SKIPPED.
   - Phase `[ ]` + step `[x]`: mark that step SKIPPED, include the rest.
   - Phase `[ ]` + step `[ ]`: include as an active numbered checkbox.
   - Append the reason from the config to any SKIPPED step.
   - Do not resolve contradictions here -- they must be caught during the input quality check before this step is reached.

3. Begin execution: work through `plan-with-human-gates.md` top-to-bottom.

### Execution rules

- Never self-execute a step assigned to a named role. Invoke the Agent tool with that role.
- Never skip ahead. A step is not started until all prior steps are checked off.
- When the orchestrator reaches the end of the list, stop and wait -- EM will add the next batch of steps.
- When a 👤 human gate is reached, stop and ask the human for approval. Check the box only after human confirms.
- After human confirms a gate, run `git diff --stat HEAD` and ask: "These files changed: [summary]. Want to commit before we move on?" If yes, invoke `/my-git-commit`.
