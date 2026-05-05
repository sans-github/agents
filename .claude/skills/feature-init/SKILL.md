---
name: feature-init
description: Scaffold a new feature folder under projects/. Creates projects/master/ (once) and projects/YYYYMMDD-feature-name/ from the template. Use when starting work on a new feature.
argument-hint: 20260417-sample-feature
---

# Feature Init

Scaffolds a new feature workspace and guides the user through requirements, config, and kickoff interactively. One command -- no manual file editing required.

**Sequence:** Requirements Kickoff → Scaffold → HTML Phase Config → Kick off

---

## Step 0: Requirements Kickoff

Open with: "Let me gather details about what you'd like to build today."

Use `AskUserQuestion` (single-select) to ask how the user wants to start:

- **Describe it now** -- you'll interview me
- **I have requirements text** -- I'll paste them
- **I have a full PRD** -- I'll paste it or give a file path

### Path A: Describe it now

Invoke the `senior-product-manager` agent with this instruction:

> "Run a short requirements interview with the user. Ask one question at a time. When you have enough context, produce: (1) a one-paragraph summary, (2) 3-5 key points, (3) a suggested 2-3 word kebab-case slug for the feature folder (e.g. `user-auth-flow`). Do not write a full PRD -- requirements summary only."

Wait for PM agent to complete. Extract the slug suggestion from its output.

### Path B: I have requirements text

Ask the user to paste their requirements. Then invoke `senior-product-manager` with:

> "The user has provided the following requirements: [paste]. Refine them into: (1) a one-paragraph summary, (2) 3-5 key points, (3) a suggested 2-3 word kebab-case slug. Requirements summary only -- no full PRD."

Extract the slug suggestion.

### Path C: I have a full PRD

Ask the user to paste the PRD content or provide a file path. If a file path is given, read the file. Derive a 2-3 word kebab-case slug from the PRD title or first heading. No PM agent invocation needed.

### Confirm the slug

After any path, present the slug suggestion to the user using `AskUserQuestion`:

> "I'll name the feature folder `YYYYMMDD-[slug]` (today's date will be prepended). Does this look right?"

Options: "Yes, use this name" / "Edit it" (user types a different slug via Other).

Hold the confirmed slug and requirements summary in context -- they are written to `prd.md` after the scaffold in Step 1.

---

## Step 1: Scaffold

Run `bash .claude/skills/feature-init/feature-init.sh YYYYMMDD-[confirmed-slug]` using Bash. IMPORTANT: always use this relative path exactly -- never expand it to an absolute path. Substitute today's date (YYYYMMDD) and the confirmed slug.

Show the user the folder tree from the script output. Extract the feature folder path from the output (format: `projects/YYYYMMDD-feature-name`) -- you will need it in every subsequent step.

**Write requirements to `prd.md`:**

- **Paths A or B:** Write the requirements frontmatter block to `[feature-folder]/product-specs/prd.md`:

  ```
  ---
  requirements:
    summary: <one paragraph from PM output>
    key_points:
      - <bullet>
      - <bullet>
    additional_context: none
    gathered_by: orchestrator-inline
  ---
  ```

- **Path C (full PRD provided):** Write the full PRD content directly to `[feature-folder]/product-specs/prd.md` (no frontmatter wrapper).

Then invoke `/my-git-commit` automatically without asking. Commit subject: `"Scaffold [feature-name] feature folder"` where `[feature-name]` is the `YYYYMMDD-feature-name` portion of the folder path.

---

## Step 2: HTML Phase Config

### Generate the HTML

Read `[feature-folder]/workflow/feature-setup.md` to extract:
- Stage names and their default state (`[ ]` active, `[-]` skipped)
- Which stages are marked as never-skippable (Stages 6 and 7 in the default template)
- Human checkpoint steps (`👤`) within each stage

Write `[feature-folder]/workflow/feature-overview.html` with the following structure:

**1. Header section**
- Feature name (derived from folder name, formatted as human-readable title)
- 1-2 sentence project summary from requirements

**2. "What to expect" intro**
A short paragraph explaining: this workflow is broken into stages; each stage may include a human review checkpoint before the next stage begins; you can skip stages that don't apply to your project; stages marked "always active" cannot be skipped.

**3. Stage configuration list**
For each stage from `feature-setup.md`:
- Checkbox (checked by default if `[ ]`, unchecked if `[-]`)
- Disabled/locked checkbox for never-skippable stages (Stages 6 and 7), visually marked as "Always active"
- Stage name as label (e.g. "Stage 1: Discovery")
- One-line description of what happens in the stage (use the stage content to infer this)
- Indented below: each `👤` human checkpoint from that stage, shown as a read-only item with a 👤 icon and text like "You'll review and approve the PRD"

**4. Deployment target**
A radio button group with options: `local` / `existing AWS infra` / `new AWS infra` / `TBD`. Default: `local`.

**5. Additional context**
A textarea with placeholder: "Whiteboard notes, sketches, constraints, preferences... (optional)"

**6. Confirm button**
On click, writes the following to `[feature-folder]/workflow/user-phase-input.json`:

```json
{
  "phases": {
    "Stage 1: Discovery": true,
    "Stage 2: Design": false
  },
  "deployment_target": "local",
  "additional_context": ""
}
```

Then shows a green "Saved! Return to Claude and type 'done'." message on the page.

### Present the HTML

Use `AskUserQuestion` (single-select):

> "Phase overview is ready. Want to open it in your browser to configure your project?"

Options:
- **Open in browser** -- CC runs `open [feature-folder]/workflow/feature-overview.html`
- **Skip, use defaults** -- skip HTML; all stages remain active, deployment target stays `local`

If "Open in browser": after running the open command, tell the user: "The overview is open. Toggle any stages you want to skip, fill in deployment target, then click Confirm. Come back here and say 'done' when finished."

Wait for the user to return and say "done" (or similar).

### Read and apply the result

Read `[feature-folder]/workflow/user-phase-input.json`.

Apply to `[feature-folder]/workflow/feature-setup.md`:
- For each stage with `false`: change its `[ ]` to `[-]` at the stage line
- Replace the deployment target `local` default in the `## Deployment target` block with the user's choice
- If `additional_context` is non-empty: replace the example block in `## Additional context` with the user's text

Delete `[feature-folder]/workflow/user-phase-input.json` after applying.

Print a plain-language summary:

```
Phases configured:
- Stage 1: Discovery        [ active ]
- Stage 2: Design           [ skipped ]
...
Deployment target: local
```

Use `[ active ]` for `[ ]` stages and `[ skipped ]` for `[-]` stages.

Then ask: "Does this look right before we continue?" with options "Yes, continue" and "No, reopen browser". If reopen, re-run the HTML flow from "Present the HTML" and repeat until the user confirms.

---

## Step 3: Kick off

Ask the user: "Config and requirements are ready. Ready to kick off?" Offer "Yes, proceed" and "Not yet".

If yes: read `.claude/template/kickoff-prompt.md`, replace every occurrence of `[YYYYMMDD-feature-name]` with the actual feature folder path (e.g. `projects/20260420-my-feature`), then execute the resulting prompt as if the user had sent it. The kickoff prompt handles everything from here.
