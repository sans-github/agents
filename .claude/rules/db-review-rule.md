# Rule: DB Schema Review

Before declaring any schema change complete -- whether a new table, a migration, or a revised schema file -- run through the checklist at `.claude/skills/db-schema/db-checklist.md`.

## When this applies

- Creating a new table or schema file
- Writing a migration (column add, type change, constraint, index)
- Dropping or renaming any schema object
- Reviewing a schema before implementation begins
- Approving a DB schema (EM role)

## What "complete" means

A schema change is not complete until every applicable checklist item is confirmed. Items that genuinely do not apply must be explicitly noted as out of scope -- not silently skipped.

## Ownership

- **BE** runs the checklist when authoring or revising schema files or migrations.
- **EM** verifies the checklist was run during schema approval (see `contract-first-rule.md`).
