# Kickoff Prompt -- Greenfield

> Fill in the variable below, then tell Claude: "Read and execute `.claude/template/kickoff-greenfield.md`."

**Feature folder:** `projects/[YYYYMMDD-feature-name]`

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the config overrides it where they differ. Also read `.claude/tech-config.md` for this project's file locations, naming conventions, and tooling choices.

The feature folder for this project is `projects/[YYYYMMDD-feature-name]`.

I'm starting a new software project from scratch. Please read the following before doing anything:

- Project config: `[feature-folder]/workflow/project-config.md`
- PRD: `[feature-folder]/product-specs/prd.md`

Then enter plan mode and produce `[feature-folder]/workflow/kickoff-plan.md` covering:

1. **What I understood** -- summarize the PRD and project config in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

   **Input quality check:** Flag any of the following before proceeding:
   - Unfilled placeholders (e.g. `[YYYYMMDD-feature-name]`, `TODO`, `TBD`, placeholder text left from the template)
   - Sections that appear untouched or still contain template defaults
   - Content in `project-config.md` or `product-specs/prd.md` that contradicts or does not match the project description
   - Sparse or vague entries where detail is needed to proceed (e.g. "active agents: all" with no rationale, or a one-line PRD)

   Do not proceed if critical inputs are missing or stale. Surface them explicitly and wait for the human to update.

2. **Software stack** -- the default stack for this project is:
   - BE: Java 21 + Spring Boot (REST API, JPA, PostgreSQL)
   - FE: React 18 + TypeScript (Redux Toolkit, TanStack Query, React Router v6, Vite)
   - Infra: Terraform on AWS
   - QA: Playwright (E2E + API)

   If anything in the PRD suggests a different stack, propose the change and explain why. Otherwise confirm the default. Any stack change requires Arch approval before it is adopted.

   Regardless of confirmation, flag any mismatch between stack weight and project scope. For each concern, call out:
   - What is too broad, unnecessary, missing, or potentially wrong
   - Why it is a concern given the project scope
   - A concrete alternative with rationale (e.g. "consider Zustand instead of Redux Toolkit for a single-page app with no complex shared state")

   Stack philosophy: prefer proven, widely adopted libraries and frameworks over novel or obscure ones. Prefer the smallest stack that covers the requirements -- every dependency added is a maintenance burden. Do not silently confirm if the scope is small or if any layer looks mismatched. Any stack change requires Arch approval -- but surface the concern regardless.

3. **Agent collaboration plan** -- based on the project config (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `[feature-folder]/workflow/project-config.md`.

4. **Big picture** -- one short paragraph describing what will be built and how the pieces fit together.

5. **Human-in-the-loop checkpoints** -- list every point where I need to review, approve, or make a decision before agents can proceed. Be specific: what artifact, who produces it, what I'm reviewing.

6. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

7. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, or anything that needs resolution before work starts.

8. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the project config and PRD.

Do not begin any work until I have reviewed and approved `[feature-folder]/workflow/kickoff-plan.md`.
