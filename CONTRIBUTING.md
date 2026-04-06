# Contributing

This repo contains Claude Code agent definitions and skills for a software engineering team. Contributions are usually one of three things: adding a skill, updating a skill, or adding a new agent role.

---

## How skills load (read this first)

> Full reference: [Three types of skill content, three levels of loading](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview#three-types-of-skill-content-three-levels-of-loading)

Skills use three levels of loading so Claude only consumes context it actually needs:

| Level | What loads | When |
|-------|-----------|------|
| 1 -- Metadata | `name` + `description` from `SKILL.md` frontmatter | Always, at startup |
| 2 -- Instructions | Body of `SKILL.md` | When the skill is triggered |
| 3 -- Resources | Individual files referenced in the body (e.g. `rest-reference.md`) | On demand, as needed |

This means: agents reference skills by name in their `skills:` frontmatter. The `SKILL.md` body references additional files. Claude reads those files only when relevant.

---

## Adding a domain skill

1. Create a folder: `.claude/skills/{skill-name}/`

2. Add a `SKILL.md` with frontmatter and orientation content. The description is what Claude reads at startup -- end it with "Use when ..." so the trigger condition is explicit:
   ```markdown
   ---
   name: my-skill
   description: What this skill covers. Use when <conditions>.
   ---

   # My Skill

   Brief orientation -- concepts, when to reach for sub-files.

   ## Resources

   - Load `my-reference.md` when actively working on X.
   - Load `my-checklist.md` before declaring work done.
   ```

3. Add any Level 3 resource files as siblings (e.g. `my-reference.md`, `my-checklist.md`).

4. Register the skill in the relevant agent files under `skills:` frontmatter:
   ```yaml
   skills:
     - my-skill
   ```

### Naming conventions

- Use kebab-case: `db-schema`, not `DBSchema` or `db_schema`
- Names must be unique across all skill files in the repo
- The `description` field should say *when* to use the skill, not just what it is -- Claude uses this to decide whether to load it

---

## Updating a skill

Edit the file directly. For `SKILL.md`, keep the `description` frontmatter accurate -- if the scope of the skill changes, update it so Claude triggers correctly.

Never rename a skill file without also updating the `name` field in its frontmatter and the reference in `SKILL.md`.

---

## Adding a new agent role

1. Create `.claude/agents/{role-name}.md` following the section order:
   ```markdown
   ---
   name: {role-name}
   description: {one-line role description and when to use this agent}
   skills:              # omit if no domain skills needed
     - {skill-name}
   ---

   You are a senior X.

   ## Core expertise
   ## Behavior
   ## Hard constraints

   ## Commit conventions

   - Commit after each discrete unit of work; no batching unrelated changes
   - No WIP commits -- every commit must leave [artifacts] in a [state]
   - Short, specific subject in imperative mood with issue reference
   - {role-specific rules}
   ```

2. Add any domain skills the role needs to its `skills:` frontmatter (see "Adding a domain skill" above).

---

## Folder reference

```
.claude/
├── agents/               # one file per role (self-contained: identity + commit conventions + skills ref)
├── skills/
│   └── {skill}/          # one folder per domain skill
│       ├── SKILL.md      # entrypoint (Level 1 + 2)
│       └── {other}.md    # reference/checklist files (Level 3)
└── rules/                # auto-loaded rules for every session
```

---

## Overriding default paths and conventions

Default file locations (e.g. `db/er-diagram.md`, `BACKLOG.md`) are defined in `CONVENTIONS.md` and enforced by the rules. If your project uses different paths, override them in your project's `CLAUDE.md`:

```markdown
## Conventions overrides

- ER diagram: `docs/er-diagram.md` (not `db/er-diagram.md`)
- Backlog: `docs/BACKLOG.md` (not `BACKLOG.md`)
```

Claude Code loads your project `CLAUDE.md` on every session, so agents will follow the overrides automatically. You do not need to modify the synced rule files.
