# Kickoff Prompt -- Greenfield

> Fill in the variable below, then tell Claude: "Read and execute `.claude/template/kickoff-greenfield.md`."

**Feature folder:** `projects/[YYYYMMDD-feature-name]`

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the config overrides it where they differ. Also read `.claude/tech-config.md` for this project's file locations, naming conventions, and tooling choices.

The feature folder for this project is `projects/[YYYYMMDD-feature-name]`.

I'm starting a new software project from scratch. Please read the following before doing anything:

- Project config: `[feature-folder]/workflow/project-config.md`
- PRD: `[feature-folder]/product-specs/prd.md`

Then produce `[feature-folder]/workflow/kickoff-plan.md` covering:

Use these emoji conventions inline throughout the plan -- on the heading, row, or bullet where the action is needed:
- 👀 Human must review and explicitly confirm before work proceeds
- ❓ Human input is missing and required -- agents cannot proceed without it
- 👤 Human gate within a collaboration loop -- human must approve before downstream work is unblocked

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

2. **Software stack** -- read the stack from `.claude/tech-config.md` (Tech stack section). Confirm each layer against the PRD scope.

   For each layer, select the minimum subset of listed technologies that covers the project requirements -- do not default to the full list. Choosing a lighter option already on the list does not require Arch approval. Arch approval is required only when adopting a technology not listed in `tech-config.md`.

   Regardless of confirmation, flag any mismatch between stack weight and project scope. For each concern, call out:
   - What is too broad, unnecessary, missing, or potentially wrong
   - Why it is a concern given the project scope
   - A concrete alternative with rationale (e.g. "consider Zustand instead of Redux Toolkit for a single-page app with no complex shared state")

   Stack philosophy: prefer proven, widely adopted libraries and frameworks over novel or obscure ones. Prefer the smallest stack that covers the requirements -- every dependency added is a maintenance burden. Do not silently confirm if the scope is small or if any layer looks mismatched. Adopting a technology not in `tech-config.md` requires Arch approval -- surface the concern regardless.

3. **Agent collaboration plan** -- based on the project config (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `[feature-folder]/workflow/project-config.md`. Human milestone gates are tracked separately in `[feature-folder]/workflow/human-checkpoints.md` -- do not list them here. Prefix each human gate step within a loop description with 👤 (e.g. `👤 Human gate: Human reviews and approves mocks before EM begins eng planning`).

4. **Big picture** -- one short paragraph describing what will be built and how the pieces fit together.

5. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

6. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, or anything that needs resolution before work starts.

7. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the project config and PRD.

8. **Next step** -- one sentence only. State exactly what happens after I approve this plan: who does what, and what artifact they produce. This must match the first gate in `human-checkpoints.md`. Example: "Once approved, Designer produces mocks for `[feature-folder]/generated-docs/mocks/` before any engineering work begins."

Do not begin any work until I have reviewed and approved `[feature-folder]/workflow/kickoff-plan.md`.

Once I approve the kickoff plan:
1. Write `Status: Approved — Human` and `Approved: YYYY-MM-DD` at the top of `kickoff-plan.md`.
2. Seed `[feature-folder]/workflow/human-checkpoints.md` with the full human gate list based on active agents and phases from `project-config.md`. Format each item as: `- [ ] [Who] produces [artifact] -- Human reviews and approves before [what is unblocked]`. Must include at minimum: PRD approved by PM, Mocks approved by PM (after PM<>Design loop), Sys Arch approved (after EM<>Arch loop), Implementation Plan approved by Human. Add any project-specific gates. For active collaboration loops (see `collaboration-loops-rule.md`), include only the human-facing gate at the end of each loop -- the point where the human must stop, review, and approve before downstream work is unblocked. Do not list internal agent-to-agent steps within a loop; those belong in `implementation-plan.md` only. Inactive loops must be noted as skipped.
3. EM produces `[feature-folder]/workflow/implementation-plan.md` as a checkbox checklist of all phases and numbered steps before any detailed design begins.

Once I approve both `human-checkpoints.md` and `implementation-plan.md`:
1. Write `Status: Approved — Human` and `Approved: YYYY-MM-DD` at the top of each file.
2. Phase execution begins. No tracker file is created -- `implementation-plan.md` is the checklist agents use directly (see `progress-tracking-rule.md`).
