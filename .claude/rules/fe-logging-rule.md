# Rule: FE Logging Review

Before declaring any frontend logging implementation complete -- whether new pages, new API calls, or changes to existing logging -- run through the checklist at `.claude/skills/fe-logging/logging-checklist.md`.

## When this applies

- Implementing a new page, route, or user-facing feature
- Adding or modifying log statements in existing code
- Configuring or changing the logger module or transport
- Reviewing a frontend PR that includes logging changes

## What "complete" means

A logging implementation is not complete until every applicable checklist item is confirmed. Items that genuinely do not apply must be explicitly noted as out of scope -- not silently skipped.

## Ownership

- **FE** runs the checklist when authoring or revising any frontend code that includes logging.
- **EM** verifies the checklist was run during PR approval (see `contract-first-rule.md`).
