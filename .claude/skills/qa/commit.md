---
name: commit-qa
description: Commit conventions for the QA Automation Engineer role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave the test suite in a passing state
- Short, specific subject in imperative mood with issue reference (e.g. `add E2E test for checkout timeout #61`)
- Never bundle test additions with the fix they cover -- commit them separately so reviewers can evaluate each independently
- Note coverage scope in the commit body when adding new test areas (e.g. what scenario is now covered and why it matters)
