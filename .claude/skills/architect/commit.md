---
name: commit-architect
description: Commit conventions for the Software Architect role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave architecture artifacts in a coherent, reviewable state
- Short, specific subject in imperative mood with issue reference (e.g. `define event schema for order service #19`)
- Isolate schema and API contract changes into their own commits; never mix with implementation
- Prefix breaking changes with `BREAKING:` in the subject so downstream teams are alerted immediately
- Commit ADRs before or alongside the implementation they justify -- never after
