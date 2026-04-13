# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A collection of reusable Claude Code sub-agent definitions for a software engineering team. There is no application code here. The repo contains only agent definitions, domain skills, session rules, and project scaffolding templates.

Consumers install this repo into their own project via `scripts/sync.sh`. They do not fork or modify this repo -- they pull it as a versioned dependency and commit the result.

## How consumers use it

1. Run `scripts/sync.sh` to copy `.claude/agents/`, `.claude/rules/`, `.claude/skills/`, `.claude/template/`, `.claude/GETTING-STARTED.md`, and `.claude/tech-custom-config.md` into their project.
2. Copy `template/master/` once to `projects/master/` -- the shared product baseline (PRD + mocks), maintained across all features.
3. Per feature: copy `template/feature/` to `projects/YYYYMMDD-feature-name/`.
4. Fill in `projects/[feature]/workflow/project-config.md` -- which agents are active, phases to skip, overrides.
5. Fill in `projects/[feature]/product-specs/prd.md` -- the feature PRD.
6. Edit the appropriate kickoff file (`template/kickoff-greenfield.md` or `template/kickoff-brownfield.md`), set the feature folder variable at the top, then tell Claude to read and execute it.

## Folder structure and the reasoning behind it

```
.claude/
├── agents/           -- agent role definitions (auto-loaded by Claude Code)
├── rules/            -- session rules (auto-loaded by Claude Code)
├── skills/           -- domain knowledge packs referenced by agents
├── template/
│   ├── feature/      -- scaffolding copied per feature into projects/YYYYMMDD-name/
│   │   ├── generated-docs/mocks/   -- Designer output (mocks, diagrams)
│   │   ├── product-specs/prd.md    -- PM input (feature PRD)
│   │   └── workflow/               -- delivery config and plans
│   ├── master/       -- copied once to projects/master/ (shared product baseline)
│   │   ├── product-specs/prd.md    -- full PRD merged across all shipped features
│   │   └── mocks/                  -- current UI mocks reflecting live product
│   ├── kickoff-greenfield.md       -- prompt for new projects (stays at template root, not copied per feature)
│   └── kickoff-brownfield.md       -- prompt for new features on existing codebase
├── GETTING-STARTED.md
└── tech-custom-config.md           -- stack/conventions consumers tailor once after install
```

Key distinctions:
- `product-specs/` is PM input (what to build). `generated-docs/` is Designer output (what was produced). Never mix them.
- `template/feature/` contains things that become part of a feature folder. Kickoff files are one-time prompts, so they stay at `template/` root.
- `master/` is a shared baseline, not per-feature. It mirrors the `feature/` structure (product-specs, mocks) but is copied once, not per feature.
- `generated-docs/` uses subfolders (e.g. `mocks/`) so future artifact types can be added without clutter.

## Rules

Rules in `.claude/rules/` are loaded automatically. Key ones to know:
- `contract-first-rule.md` -- no downstream work until upstream artifact is approved. Strict sequencing.
- `product-baseline-rule.md` -- `projects/master/` must stay current. PM and Designer are blocked from starting new features until it is.
- `backlog-reporting-rule.md` -- agents append discovered bugs/debt to `BACKLOG.md` in the repo root. Never self-assign priority.
- `progress-tracking-rule.md` -- maintain `implementation-plan-tracker.md` throughout any phased task.

## What NOT to do

- Do not add application code, project-specific content, or anything that assumes a particular consumer project.
- Do not create new folders without understanding where they fit in the input/output separation (product-specs vs generated-docs, feature vs master).
- Do not rename or restructure without grepping the full repo for references and updating all of them.
- Do not commit without the user explicitly asking.

## Agent conventions

Each agent file follows this section order:
1. Frontmatter (`name`, `description`, optional `skills`)
2. One-line identity (`You are a senior X.`)
3. `## Core expertise` -- qualities and collaboration
4. `## Behavior` -- mindset, ownership, decision-making, communication
5. `## Hard constraints`
6. `## Commit conventions` -- role-specific commit rules

## Skill naming

Skills are resolved by the `name` field in their frontmatter, not by folder path. Skill names must be unique. Agents list skills in their `skills:` frontmatter. Commit conventions live in each agent file, not in a separate skill.

## Sync script

```bash
bash scripts/sync.sh          # pull from main
bash scripts/sync.sh v1.2.0   # pin a tag or branch
```

Copies `.claude/agents/`, `.claude/rules/`, `.claude/skills/`, `.claude/template/`, `.claude/GETTING-STARTED.md`, and `.claude/tech-custom-config.md` into the consumer project. Also scaffolds `BACKLOG.md` in the consumer root if it doesn't exist. Consumers commit the result to lock the version.
