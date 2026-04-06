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
| 3 -- Resources | Individual files referenced in the body (e.g. `commit.md`) | On demand, as needed |

This means: agents reference the `SKILL.md` by name. The `SKILL.md` body references additional files. Claude reads those files only when relevant.

---

## Adding a skill to an existing role

1. Create a new `.md` file in the role's skill folder, e.g. `.claude/skills/be/my-skill.md`. If the skill is relevant to more than one role, give it its own top-level folder (e.g. `.claude/skills/my-skill/SKILL.md`) and reference it from each role's `SKILL.md` using a relative path (e.g. `../my-skill/SKILL.md`).

2. Add frontmatter with a `name` and `description`. The description is what Claude reads at startup to decide whether to trigger the skill -- end it with "Use when ..." so the trigger condition is explicit:
   ```markdown
   ---
   name: my-skill
   description: What this skill covers. Use when <conditions>.
   ---

   # My Skill
   ...content...
   ```

3. Register it in the role's `SKILL.md` under `## Available skills`:
   ```markdown
   - **my-skill** (`my-skill.md`) -- one-line description
   ```

That's it. No changes to the agent file needed.

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
   ```
   ---
   name: {role-name}
   description: {one-line role description and when to use this agent}
   skills:
     - {role-abbrev}
   ---

   You are a senior X.

   ## Core expertise
   ## Behavior
   ## Hard constraints
   ```

2. Create a skill folder: `.claude/skills/{role-abbrev}/`

3. Add a `SKILL.md` in that folder (Level 1/2 entrypoint):
   ```markdown
   ---
   name: {role-abbrev}
   description: {role} guidance including ... Use when ...
   ---

   ## Available skills

   - **commit** (`commit.md`) -- commit conventions for the {role} role
   ```

4. Add at minimum a `commit.md` skill file for the role.

---

## Folder reference

```
.claude/
├── agents/          # one file per role
├── skills/
│   ├── {skill}/             # standalone skills (cross-role or standalone)
│   │   └── SKILL.md
│   └── {role}/
│       ├── SKILL.md         # entrypoint (Level 1 + 2)
│       ├── commit.md        # commit conventions (Level 3)
│       └── {other}.md       # additional skills (Level 3)
└── rules/           # auto-loaded rules for every session
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
