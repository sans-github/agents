---
purpose: >
  Filled in by the human before any agent begins work.
  Configures which agents are active, which phases to include or skip,
  and any deviations from the default collaboration pattern.
  Agents must read this before doing anything and use it to seed plan-with-human-gates.md.
---

# Project Config

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

## Project phases

The orchestrator reads this to seed `plan-with-human-gates.md`.

Toggle rules:
- Phase `[ ]` + step `[ ]` -- active, include in the plan
- Phase `[ ]` + step `[x]` -- skip this step only, include the rest
- Phase `[x]` -- skip all steps in this phase regardless of step-level markers

---

- [ ] **prd**
  - [ ] **PM:** review PRD with human, surface open questions, confirm scope → `product-specs/prd.md`
  - [ ] 👤 **HUMAN:** review and approve PRD

- [ ] **mocks**
  - [ ] **DESIGNER:** produce mocks → `generated-docs/mocks/`
  - [ ] 👤 **HUMAN:** review and approve mocks before EM begins eng planning

- [ ] **handoff**
  - [ ] **EM:** PM→EM handoff, evaluate arch engagement, record decision in `workflow/feature-workflow-config.md`

- [ ] **arch**
  - [ ] **ARCH:** produce system architecture → `generated-docs/sys-arch.md` + `generated-docs/sys-arch.html`
  - [ ] 👤 **HUMAN:** review and approve sys-arch before HLD begins

- [ ] **hld**
  - [ ] **EM:** produce HLD → `generated-docs/hld.md` + `generated-docs/hld.html`
  - [ ] 👤 **HUMAN:** review and approve HLD before detailed design begins

- [ ] **impl-plan**
  - [ ] **EM:** produce detailed implementation plan, add remaining phases to this doc
  - [ ] 👤 **HUMAN:** review and approve implementation plan before execution begins

---

## Collaboration overrides

List any deviations from the default collaboration loops defined in `collaboration-loops-rule.md`.

```
# Example:
- PM skips the Design review loop (Designer is inactive)
- BE and FE may finalize the API contract without EM sign-off for this project
  (EM is monitoring but has delegated this to the team given scope)
- QA automation is deferred to Phase 2 of the product roadmap; SDET is inactive now
```

---

## Deployment target

Declare the deployment intent for this project. Agents use this to determine whether DevOps/IaC work is in scope.

```
# Options: local | existing AWS infra | new AWS infra | TBD
local
```

---

## Additional context

Include anything that should inform plan-with-human-gates.md -- handwritten notes, whiteboard photos, Excalidraw diagrams, sketches, or rough ideas. Agents must respect and factor all of this in when generating plan-with-human-gates.md.

```
# Example:
- See product-specs/whiteboard-sketch.jpg for a rough flow diagram
- The team discussed keeping the data model flat -- avoid joins where possible
- The PM has a strong preference for shipping Phase 1 without auth; add auth in Phase 2
- Excalidraw collaboration diagram is at workflow/collaboration-map.excalidraw
```
