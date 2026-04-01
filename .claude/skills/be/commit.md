---
name: commit-be
description: Commit conventions for the Backend Engineer role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave the codebase in a working, buildable state
- Short, specific subject in imperative mood with issue reference (e.g. `add rate limiting to /api/orders #87`)
- Separate DB migrations from application code commits; never bundle schema changes with feature code
- Mark API contract changes explicitly in the subject line (e.g. `change /users response shape #102`)
