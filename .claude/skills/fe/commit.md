---
name: commit-fe
description: Commit conventions for the Frontend Engineer role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave the UI in a working, renderable state
- Short, specific subject in imperative mood with issue reference (e.g. `fix modal focus trap on close #73`)
- Separate component logic, styling, and accessibility changes into distinct commits where practical
- Never commit build artifacts; add them to `.gitignore` if not already excluded
- Note breaking visual changes in the commit body so reviewers know to check screenshots or run visual regression
