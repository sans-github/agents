# Kickoff Prompt -- Greenfield

> Copy this file, fill in any [placeholders], and paste it into Claude Code to kick off a new project with no existing codebase.

---

First, read `.claude/agents-guide.md` for orientation on the agent team, collaboration model, and rules. Not everything there will apply to this project -- the config overrides it where they differ. Also read `.claude/tech-custom-config.md` for this project's file locations, naming conventions, and tooling choices.

I'm starting a new software project from scratch. Please read the following before doing anything:

- Project config: `workflow/project-config.md`
- PRD: `product-specs/prd.md`

Then enter plan mode and produce `workflow/kickoff-plan.md` covering:

1. **What I understood** -- summarize the PRD and project config in your own words. Call out anything ambiguous or missing that I should clarify before work begins.

2. **Software stack** -- the default stack for this project is:
   - BE: Java 21 + Spring Boot (REST API, JPA, PostgreSQL)
   - FE: React 18 + TypeScript (Redux Toolkit, TanStack Query, React Router v6, Vite)
   - Infra: Terraform on AWS
   - QA: Playwright (E2E + API)

   If anything in the PRD suggests a different stack, propose the change and explain why. Otherwise confirm the default. Any stack change requires Arch approval before it is adopted.

3. **Agent collaboration plan** -- based on the project config (active agents, skipped phases, overrides), describe how the agents will collaborate for this project. Reference the workflow defined in `workflow/project-config.md`.

4. **Big picture** -- one short paragraph describing what will be built and how the pieces fit together.

5. **Human-in-the-loop checkpoints** -- list every point where I need to review, approve, or make a decision before agents can proceed. Be specific: what artifact, who produces it, what I'm reviewing.

6. **Open questions** -- a numbered list of questions that need my answers before agents can proceed. Do not make assumptions; surface the gaps here.

7. **Risks and unknowns** -- anything you spotted that could slow the project down: unclear requirements, missing design decisions, external dependencies, or anything that needs resolution before work starts.

8. **Out of scope** -- explicitly state what is NOT being built in this project run, based on the project config and PRD.

Do not begin any work until I have reviewed and approved `workflow/kickoff-plan.md`.
