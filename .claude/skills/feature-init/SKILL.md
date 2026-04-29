---
name: feature-init
description: Scaffold a new feature folder under projects/. Creates projects/master/ (once) and projects/YYYYMMDD-feature-name/ from the template. Use when starting work on a new feature.
argument-hint: 20260417-sample-feature
---

# Feature Init

Scaffolds a new feature workspace and guides the user through config, requirements, and kickoff interactively. One command -- no manual file editing required.

## Steps

### 1. Scaffold

Run `bash .claude/skills/feature-init/feature-init.sh FEATURE_NAME` using Bash, substituting the feature name argument. If no name was provided by the user, ask for one before running. IMPORTANT: always use this relative path exactly -- never expand it to an absolute path.

Show the user the folder tree from the script output. Extract the feature folder path from the output (format: `projects/YYYYMMDD-feature-name`) -- you will need it in every subsequent step.

Then invoke `/my-git-commit` automatically without asking. Commit subject: "Scaffold [feature-name] feature folder" where `[feature-name]` is the `YYYYMMDD-feature-name` portion of the folder path.

---

### 2. Configure (CC)

Use `AskUserQuestion` to gather the following in a single call (3 questions):

**Q1 -- Phases (multiSelect):** "Which phases should be active for this feature?" Read the stage names and their current state (`[ ]` or `[-]`) from `[feature-folder]/workflow/feature-setup.md` (lines starting with `### Stage`). Present each as an option, pre-selected if `[ ]` and pre-deselected if `[-]`.

**Q2 -- Deployment target (single select):** "Where will this feature be deployed?"
- local
- existing AWS infra
- new AWS infra
- TBD

**Q3 -- Additional context (single select):** "Any additional context for the agents? (whiteboard notes, sketches, constraints, preferences)"
- No additional context
- Yes, I'll add it now (user provides free text via Other)

Then write the answers into `[feature-folder]/workflow/feature-setup.md`:
- Stages the user did NOT select: change their `[ ]` to `[-]` at the stage level
- Deployment target: replace the `local` default in the `## Deployment target` block with the user's choice
- Additional context: if provided, replace the example block in `## Additional context` with the user's text; if none, leave the block as-is

After writing the config, print a plain-language summary of the final phase state read from `[feature-folder]/workflow/feature-setup.md`:

```
Phases configured:
- Stage 1: Discovery        [ active ]
- Stage 2: UI/UX Design     [ skipped ]
...
```

Use `[ active ]` for `[ ]` stages and `[ skipped ]` for `[-]` stages.

Then ask: "Does this look right before we continue?" with options "Yes, continue" and "No, let me adjust". If the user chooses to adjust, re-run the `AskUserQuestion` configure block from Step 2 and rewrite the config before showing the summary again. Repeat until the user confirms.

---

### 3. Requirements (PM agent)

Check if `[feature-folder]/product-specs/prd.md` is non-empty.

**If non-empty:** Read the first ~20 lines. Show the user a 1-2 line summary and ask: "A PRD already exists. Use it or start fresh?" If discard, truncate the file to empty and proceed as if empty. If reuse, invoke the PM agent with: "The feature folder is `[feature-folder]`. A PRD already exists at `product-specs/prd.md`. Review it with the user, confirm scope, and refine if needed." Then wait for PM to complete before proceeding to Step 4.

**If empty:** Adopt the PM role inline and run a short requirements interview with the user directly in this conversation thread. Ask one clarifying question at a time until you have enough to summarize. When done, write the collected requirements as a frontmatter block at the top of `[feature-folder]/product-specs/prd.md`:

```
---
requirements:
  summary: <one paragraph>
  key_points:
    - <bullet>
    - <bullet>
  additional_context: <from Step 2, or none>
  gathered_by: orchestrator-inline
---
```

Then invoke the PM agent with: "The feature folder is `[feature-folder]`. Requirements have already been gathered and are in the frontmatter of `product-specs/prd.md`. Skip the interview and proceed directly to writing the PRD."

Wait for PM to complete before proceeding. Then invoke `/my-git-commit` automatically without asking. Commit subject: "Add PRD for [feature-name]" where `[feature-name]` is the `YYYYMMDD-feature-name` portion of the folder path.

**Note:** This step is unconditional. Stage config does not gate it. PM runs whenever the PRD is empty, regardless of whether Stage 1 is `[ ]` or `[-]` in `feature-setup.md`. Stage config controls what appears in `delivery-tracker.md`, not whether the PRD exists.

---

### 4. Kick off

Ask the user: "Config and PRD are ready. Ready to kick off?" Offer "Yes, proceed" and "Not yet".

If yes: read `.claude/template/kickoff-prompt.md`, replace every occurrence of `[YYYYMMDD-feature-name]` with the actual feature folder path (e.g. `projects/20260420-my-feature`), then execute the resulting prompt as if the user had sent it. The kickoff prompt handles everything from here.
