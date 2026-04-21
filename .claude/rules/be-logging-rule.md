# Rule: BE Logging Review

Before declaring any backend logging implementation complete -- whether new endpoints, new service layers, or changes to existing logging -- run through the checklist at `.claude/skills/be-logging/logging-checklist.md`.

## When this applies

- Implementing a new API endpoint or service layer
- Adding or modifying log statements in existing code
- Configuring or changing the logging stack (appenders, log levels, access log pattern)
- Reviewing a backend PR that includes logging changes

## What "complete" means

A logging implementation is not complete until every applicable checklist item is confirmed. Items that genuinely do not apply must be explicitly noted as out of scope -- not silently skipped.

## Ownership

- **BE** runs the checklist when authoring or revising any backend code that includes logging.
- **EM** verifies the checklist was run during PR approval (see `contract-first-rule.md`).
