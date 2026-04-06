# Rule: API Design Review

Before declaring any REST API design complete -- whether a new API, a new endpoint added to an existing API, or a revised contract -- run through the checklist at `.claude/skills/api-design-principles/api-checklist.md`.

## When this applies

- Designing a new REST API or API contract
- Adding or modifying endpoints
- Reviewing an API spec before implementation begins
- Approving an API contract (EM role)

## What "complete" means

An API design is not complete until every applicable checklist item is confirmed. Items that genuinely do not apply (e.g. rate limiting on an internal-only endpoint) must be explicitly noted as out of scope -- not silently skipped.

## Ownership

- **BE** runs the checklist when authoring or revising an API contract.
- **EM** verifies the checklist was run during API contract approval (see `contract-first-rule.md`).
