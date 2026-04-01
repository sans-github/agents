---
name: commit-pm
description: Commit conventions for the Product Manager role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must represent a complete, reviewable spec change
- Short, specific subject in imperative mood with issue reference (e.g. `add offline mode acceptance criteria #28`)
- PRD and spec updates are standalone commits -- never bundled with other file types
- Version-stamp major spec revisions in the subject so reviewers can track evolution (e.g. `update PRD v2: remove phase-3 scope #31`)
