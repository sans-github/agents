# Kickoff Prompt -- Brownfield

> Fill in the variable below, then tell Claude: "Read and execute `.claude/template/kickoff-brownfield.md`."

**Feature folder:** `projects/[YYYYMMDD-feature-name]`

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the config overrides it where they differ. Also read `.claude/tech-custom-config.md` for this project's file locations, naming conventions, and tooling choices.

The feature folder for this project is `projects/[YYYYMMDD-feature-name]`.

I'm adding a new feature to an existing project. Please read the following before doing anything:

- Project config: `[feature-folder]/workflow/project-config.md`
- PRD: `[feature-folder]/product-specs/prd.md`
- Existing project context: `CLAUDE.md`

Read `CLAUDE.md` to understand the existing software stack, conventions, and project structure. Do not propose stack changes unless the project config explicitly calls for them -- this is an existing codebase and the stack is already decided.

Then enter plan mode and produce `[feature-folder]/workflow/kickoff-plan.md` covering:

1. **What I understood** -- summarize the PRD and project config in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

2. **Existing stack** -- confirm the stack you found in `CLAUDE.md`. List the key technologies for BE, FE, infra, and QA. If anything in the PRD cannot be addressed with the existing stack, flag it explicitly -- any new technology requires Arch approval before it is adopted.

   Regardless, flag any mismatch between stack weight and feature scope -- e.g. if the feature is a simple form or read-only list, call out whether the existing stack complexity is justified for this scope. Do not silently confirm.

3. **Agent collaboration plan** -- based on the project config (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `[feature-folder]/workflow/project-config.md`.

4. **Big picture** -- one short paragraph describing what will be built and how it fits into the existing product.

5. **Human-in-the-loop checkpoints** -- list every point where I need to review, approve, or make a decision before agents can proceed. Be specific: what artifact, who produces it, what I'm reviewing.

6. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

7. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, integration risks with the existing codebase, or anything that needs resolution before work starts.

8. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the project config and PRD.

Do not begin any work until I have reviewed and approved `[feature-folder]/workflow/kickoff-plan.md`.
