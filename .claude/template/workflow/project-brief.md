---
purpose: >
  Filled in by the human before any agent begins work.
  Configures which agents are active, which phases are skipped,
  and any deviations from the default collaboration pattern.
  Agents must read this before doing anything and factor it into implementation-plan.md.
---

# Project Brief

## Active agents

List the roles that are in play for this project. Unlisted roles are inactive and must not be engaged.

```
# Full roster -- comment out or remove roles that are inactive for this project:
- PM
- EM
- Arch
- Designer
- BE
- FE
- DevOps
- QA
```

---

## Skipped phases

List any phases from the default workflow that are skipped for this project, and the reason.

```
# Example:
- Phase 2 (Design): skip -- no mockups needed, internal tool with no new UI patterns
- DevOps / IaC: skip -- deploying to existing infrastructure, no new AWS components
```

---

## Collaboration overrides

List any deviations from the default agent collaboration behavior defined in the agent files.

```
# Example:
- PM skips the Design review loop (Designer is inactive)
- BE and FE may finalize the API contract without EM sign-off for this project
  (EM is monitoring but has delegated this to the team given scope)
- QA automation is deferred to Phase 2 of the product roadmap; SDET is inactive now
```

---

## Additional context

Include anything that should inform implementation-plan.md -- handwritten notes, whiteboard photos, Excalidraw diagrams, sketches, or rough ideas. Agents must respect and factor all of this in when generating implementation-plan.md.

```
# Example:
- See requirements/whiteboard-sketch.jpg for a rough flow diagram
- The team discussed keeping the data model flat -- avoid joins where possible
- The PM has a strong preference for shipping Phase 1 without auth; add auth in Phase 2
- Excalidraw collaboration diagram is at workflow/collaboration-map.excalidraw
```
