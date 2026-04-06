# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

A collection of reusable, generic Claude Code sub-agent definitions for a software engineering team. No application code -- the repo contains only agent definitions, domain skills, and session rules.

## Structure

- `.claude/agents/` -- agent definition files loaded automatically by Claude Code. Each file is a complete, self-contained role definition (no project-specific content).
- `.claude/skills/{skill}/` -- standalone domain skills (e.g. `api-design-principles/`, `db-schema/`, `java-springboot/`), each with a `SKILL.md`. Agents reference these directly in their `skills:` frontmatter.
- `.claude/rules/` -- rules that apply automatically to every session: `workflow-phases-rule.md`, `progress-tracking-rule.md`, `backlog-reporting-rule.md`, `contract-first-rule.md`, `er-diagram-rule.md`.

## Skill naming

Skills are resolved by the `name` field in their frontmatter, not by folder path. Skill names must be unique across all skill files. Agents list skills directly in their `skills:` frontmatter. Commit conventions live in each agent file under `## Commit conventions` -- not in a separate skill file.

## Sync script

Consumers install this repo into their own project with:

```bash
bash scripts/sync-agents.sh          # pull from main
bash scripts/sync-agents.sh v1.2.0   # pin a tag or branch
```

This overwrites `.claude/agents/`, `.claude/rules/`, and `.claude/skills/` in the target project. Consumers commit the result to lock the version.

## Agent conventions

Each agent file follows this section order:
1. Frontmatter (`name`, `description`, optional `skills`)
2. One-line identity (`You are a senior X.`)
3. `## Core expertise` -- qualities and collaboration
4. `## Behavior` -- mindset, ownership, decision-making, communication
5. `## Hard constraints`
6. `## Commit conventions` -- role-specific commit rules
