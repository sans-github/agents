# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Log

Maintain a log at `.claude/claude-log.md`. Update it throughout the session with:
- What you did and why
- Files touched and files changed
- Decisions made and the reasoning behind it

## Repository purpose

A collection of reusable, generic Claude Code sub-agent definitions for a software engineering team. No application code -- the repo contains only agent definitions, role-specific skills, and session rules.

## Structure

- `.claude/agents/` -- agent definition files loaded automatically by Claude Code. Each file is a complete, self-contained role definition (no project-specific content).
- `.claude/skills/{role}/` -- skills available to each agent. Each role folder has a `SKILL.md` (entrypoint listing available skills) and one or more skill files (e.g. `commit.md`).
- `.claude/rules/` -- rules that apply automatically to every session: `workflow-phases-rule.md`, `progress-tracking-rule.md`, `backlog-reporting-rule.md`, `contract-first-rule.md`, `er-diagram-rule.md`.

## Skill naming

Skills are resolved by the `name` field in their frontmatter, not by folder path. Skill names must be unique across all skill files. Each agent references its role's `SKILL.md` entrypoint by the role abbreviation (e.g. `be`, `em`). The `SKILL.md` body lists additional skill files (e.g. `commit.md`, `db-schema.md`) which Claude loads as needed.

## Sync script

Consumers install this repo into their own project with:

```bash
bash scripts/sync-agents.sh          # pull from main
bash scripts/sync-agents.sh v1.2.0   # pin a tag or branch
```

This overwrites `.claude/agents/`, `.claude/rules/`, and `.claude/skills/` in the target project. Consumers commit the result to lock the version.

## Agent conventions

Each agent file follows this section order:
1. Frontmatter (`name`, `description`, `skills`)
2. One-line identity (`You are a senior X.`)
3. `## Core expertise` -- qualities and collaboration
4. `## Behavior` -- mindset, ownership, decision-making, communication
5. `## Hard constraints`
