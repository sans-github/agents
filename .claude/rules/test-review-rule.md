# Rule: Test Review

Before merging any test code -- new tests, modified tests, or test infrastructure changes -- run through the checklist at `.claude/skills/java-testing/test-checklist.md`.

## When this applies

- Adding new test classes or test methods
- Modifying existing tests
- Reviewing a pull request that includes test changes

## What "complete" means

A test suite is not merge-ready until every applicable checklist item is confirmed. Items that genuinely do not apply must be explicitly noted as out of scope -- not silently skipped.

## Ownership

- **QA** runs the checklist when authoring or reviewing tests.
- **BE** runs the checklist when tests accompany a backend implementation PR.
- **EM** verifies the checklist was run during PR approval.
