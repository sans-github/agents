# Claude Sub-Agent Team

A collection of reusable, generic Claude Code sub-agent definitions for a software engineering team. Each agent represents a distinct engineering or product role with well-defined expertise, collaboration style, and hard constraints.

## Agents

| Agent | Description |
|-------|-------------|
| `senior-engineering-manager` | Owns architecture, delivery planning, API contracts, QA plan, and phase sign-off across all workstreams |
| `senior-product-manager` | Owns PRD and acceptance criteria; defines delivery phases and drives cross-functional alignment |
| `senior-software-architect` | Owns system-wide technical direction, structural integrity, and critical path design review |
| `senior-frontend-engineer` | Builds accessible, performant UI with full ownership of components, state, routing, and API integration |
| `senior-backend-engineer` | Designs and implements the full backend stack including DB schema, API, auth, and Terraform infra |
| `senior-devops-engineer` | Owns CI/CD pipelines, cloud infrastructure (IaC), observability stack, and security posture end-to-end |
| `senior-qa-automation-engineer` | Owns full test pipeline including strategy, test files, CI wiring, and quality gates |
| `senior-ux-ui-designer` | Creates distinctive, production-grade interfaces and complete design artifacts |

Agent files live in `.claude/agents/` and are automatically loaded by Claude Code.

## Structure

Each agent definition covers:
- **Core expertise** -- role-specific skills, qualities, and standards
- **Collaboration** -- how this role works with each other role
- **Behavior** -- mindset, ownership, decision-making, and communication norms
- **Hard constraints** -- non-negotiable rules that govern the role

## Skills

Each role has a folder under `.claude/skills/{role}/` containing:

- `SKILL.md` -- entrypoint listing available skills for the role
- `commit.md` -- commit message conventions specific to the role (and any future skills)

Agent frontmatter references skills by the `name` field in the skill file's frontmatter (e.g. `skills: - commit-em`), not by folder path. Skill names must be unique across all skill files -- folder organization is for humans, not for Claude Code's resolver.

## Rules

Rules in `.claude/rules/` apply automatically to every session:

- **workflow-phases-rule** -- multi-step work must be defined as a phased workflow with numbered steps, responsible roles, and concrete artifacts
- **progress-tracking-rule** -- maintain a `PHASES-CHECKLIST.md` alongside any workflow; verify artifacts before checking off steps
- **backlog-reporting-rule** -- append discovered bugs and tech debt to `BACKLOG.md` triage table
- **er-diagram-rule** -- maintain a current ER diagram at `db/er-diagram.md`; update it in the same commit as any schema change

## Usage guide

```bash
bash scripts/sync-agents.sh          # sync latest
bash scripts/sync-agents.sh v1.2.0   # pin a tag or branch
```

This clones the upstream repo and overwrites `.claude/agents`, `.claude/rules`, and `.claude/skills` in your project. Commit the result to lock the version