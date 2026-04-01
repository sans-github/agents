---
name: commit-em
description: Commit conventions for the Engineering Manager role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must represent a complete, reviewable decision or change
- Short, specific subject in imperative mood with issue reference (e.g. `add phase-2 delivery plan #14`)
- Commit ADRs and decision docs as standalone commits, separate from any config or code changes
- Use `docs:` prefix for documentation-only commits to make triage fast
