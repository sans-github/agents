# Kickoff Prompt -- Brownfield

> Fill in the variable below, then tell Claude: "Read and execute `.claude/template/kickoff-brownfield.md`."

**Feature folder:** `projects/[YYYYMMDD-feature-name]`

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the config overrides it where they differ. Also read `.claude/tech-config.md` for this project's file locations, naming conventions, and tooling choices.

The feature folder for this project is `projects/[YYYYMMDD-feature-name]`.

I'm adding a new feature to an existing project. Please read the following before doing anything:

- Project config: `[feature-folder]/workflow/project-config.md`
- PRD: `[feature-folder]/product-specs/prd.md`
- Existing project context: `CLAUDE.md`

Read `CLAUDE.md` to understand the existing software stack, conventions, and project structure. Do not propose stack changes unless the project config explicitly calls for them -- this is an existing codebase and the stack is already decided.

Then enter plan mode and produce `[feature-folder]/workflow/kickoff-plan.md` covering:

Use these emoji conventions inline throughout the plan -- on the heading, row, or bullet where the action is needed:
- 👀 Human must review and explicitly confirm before work proceeds
- ❓ Human input is missing and required -- agents cannot proceed without it

1. **What I understood** -- summarize the PRD and project config in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

   **Folder structure check:** Verify the feature folder exists and contains the expected structure:
   - `[feature-folder]/workflow/project-config.md`
   - `[feature-folder]/product-specs/prd.md`
   - `[feature-folder]/generated-docs/mocks/`

   If any are missing, stop and tell the human exactly what is missing before proceeding.

   **Input quality check:** Flag any of the following before proceeding:
   - Unfilled placeholders (e.g. `[YYYYMMDD-feature-name]`, `TODO`, `TBD`, placeholder text left from the template)
   - Sections that appear untouched or still contain template defaults
   - Content in `project-config.md` or `product-specs/prd.md` that contradicts or does not match the project description
   - Sparse or vague entries where detail is needed to proceed (e.g. "active agents: all" with no rationale, or a one-line PRD)

   Do not proceed if critical inputs are missing or stale. Surface them explicitly and wait for the human to update.

2. **Existing stack** -- confirm the stack you found in `CLAUDE.md`. List the key technologies for BE, FE, infra, and QA. If anything in the PRD cannot be addressed with the existing stack, flag it explicitly -- any new technology requires Arch approval before it is adopted.

   Regardless, flag any mismatch between stack weight and feature scope -- e.g. if the feature is a simple form or read-only list, call out whether the existing stack complexity is justified for this scope. Do not silently confirm.

3. **Agent collaboration plan** -- based on the project config (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `[feature-folder]/workflow/project-config.md`.

4. **Big picture** -- one short paragraph describing what will be built and how it fits into the existing product.

5. **Human-in-the-loop checkpoints** -- produce this as a checklist. Each item is a blocking gate: the human must explicitly approve before the next step proceeds. Format each item as:

   `- [ ] [Who] produces [artifact] -- Human reviews and approves before [what is unblocked]`

   Be specific and complete. Every checkpoint from the collaboration plan must appear here.

   For any active collaboration loop (see `collaboration-loops-rule.md`), expand it into its discrete steps -- do not collapse a multi-role loop into a single checkpoint line. Inactive loops must be noted as skipped.

6. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

7. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, integration risks with the existing codebase, or anything that needs resolution before work starts.

   **Tech-config risk:** If `.claude/tech-config.md` has changed since the last feature (or if this feature requires a change to it), assess the impact on the live codebase. For each change, call out:
   - What changed and why
   - Which parts of the existing codebase are affected
   - Risk level (low / medium / high) and reasoning
   - Estimated extent of refactor (e.g. "touches 3 files" vs "affects all API endpoints")
   - Whether it could introduce regressions in live features

   If the change introduces a new dependency or technology, apply the same stack philosophy as greenfield: prefer proven, widely adopted libraries over novel or obscure ones; prefer the smallest addition that covers the need. If a simpler alternative exists, propose it with rationale before accepting the proposed change.

   Do not proceed past this flag without explicit human sign-off.

8. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the project config and PRD.

9. **Next step** -- one sentence only. State exactly what happens after I approve this plan: who does what, and what artifact they produce. This must match the sequence in section 5 exactly. Example: "Once approved, Designer produces mocks for `[feature-folder]/generated-docs/mocks/` before any engineering work begins."

Do not begin any work until I have reviewed and approved `[feature-folder]/workflow/kickoff-plan.md`.
