---
name: commit-ux
description: Commit conventions for the UX/UI Designer role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave design files in a consistent, reviewable state
- Short, specific subject in imperative mood with issue reference (e.g. `update button states for disabled variant #44`)
- No binary design files (Figma exports, PSDs, sketch files) in git; link to the design tool instead
- Commit design token changes separately from component changes; token changes have wider blast radius
- Note visual regression risk in the commit body when changing shared tokens or global styles
