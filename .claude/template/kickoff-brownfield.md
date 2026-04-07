# Kickoff Prompt -- Brownfield

> Copy this file, fill in any [placeholders], and paste it into Claude Code to kick off a new feature on an existing codebase.

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the brief overrides it where they differ. Also read `.claude/CONVENTIONS.md` for this project's file locations, naming conventions, and tooling choices.

I'm adding a new feature to an existing project. Please read the following before doing anything:

- Project brief: `workflow/project-brief.md`
- Requirements: `requirements/requirements.md`
- Existing project context: `CLAUDE.md`

Read `CLAUDE.md` to understand the existing software stack, conventions, and project structure. Do not propose stack changes unless the brief explicitly calls for them -- this is an existing codebase and the stack is already decided.

Then enter plan mode and produce `workflow/kickoff-plan.md` covering:

1. **What I understood** -- summarize the requirements and brief in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

2. **Existing stack** -- confirm the stack you found in `CLAUDE.md`. List the key technologies for BE, FE, infra, and QA. If anything in the requirements cannot be addressed with the existing stack, flag it explicitly -- any new technology requires Arch approval before it is adopted.

3. **Agent collaboration plan** -- based on the project brief (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `workflow/project-brief.md`.

4. **Big picture** -- one short paragraph describing what will be built and how it fits into the existing product.

5. **Human-in-the-loop checkpoints** -- list every point where I need to review, approve, or make a decision before agents can proceed. Be specific: what artifact, who produces it, what I'm reviewing.

6. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

7. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, integration risks with the existing codebase, or anything that needs resolution before work starts.

8. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the brief and requirements.

Do not begin any work until I have reviewed and approved `workflow/kickoff-plan.md`.
