---
purpose: >
  Filled in by the human before any agent begins work.
  Configures which agents are active, which phases to include or skip,
  and any deviations from the default collaboration pattern.
  Agents must read this before doing anything and use it to seed plan-with-human-gates.md.
---

# Project Config

## Active agents

All roles below are active. Mark `[-]` to exclude a role from this project.

- [ ] PM
- [ ] EM
- [ ] Arch
- [ ] Designer
- [ ] BE
- [ ] FE
- [ ] DevOps
- [ ] QA

---

## Project phases

The orchestrator reads this to seed `plan-with-human-gates.md`.

Toggle rules:
- `[ ]` -- active, include in the plan
- `[-]` -- skip. Apply to a stage to exclude all its steps -- no need to mark individual steps inside it.

---

### Stage 1: Discovery

- [ ] **Requirements Finalization**
  - [ ] **PM:** review PRD with human, surface open questions, confirm scope → `product-specs/prd.md`
  - [ ] 👤 **HUMAN:** review and approve PRD

---

### Stage 2: Design

- [ ] **UI / UX Design**
  - [ ] **DESIGNER:** produce mocks → `generated-docs/mocks/`
  - [ ] 👤 **HUMAN:** review and approve mocks

---

### Stage 3: Technical Planning

- [ ] **Engineering Kickoff**
  - [ ] **EM:** receive approved PRD and mocks from PM, decide on architecture engagement, record decision in `workflow/feature-workflow-config.md`

- [ ] **System Architecture** *(skip if no new infrastructure or unfamiliar technology)*
  - [ ] **ARCH:** produce system architecture → `generated-docs/sys-arch.md` + `generated-docs/sys-arch.html`
  - [ ] 👤 **HUMAN:** review and approve system architecture

- [ ] **High-Level Design**
  - [ ] **EM:** produce high-level design → `generated-docs/hld.md` + `generated-docs/hld.html`
  - [ ] 👤 **HUMAN:** review and approve high-level design

- [ ] **Implementation Plan**
  - [ ] **EM:** produce detailed implementation plan, replace Stage 4 and Stage 5 skeleton steps with artifact-specific tasks; every step written must include a done condition (e.g. "done when: Status: Approved written to file" or "done when: human confirms")
  - [ ] 👤 **HUMAN:** review and approve implementation plan

---

### Stage 4: Engineering
> Skeleton -- EM replaces these steps with artifact-specific tasks during Implementation Planning.
> EM may reorder, split, or merge phases. This structure is a starting point only.

- [ ] **API Contract**
  - [ ] **BE + FE:** align on API contract → `generated-docs/api-contract.md` + `generated-docs/api-contract.html`
  - [ ] **EM:** review and approve API contract

- [ ] **Backend Development**
  - [ ] **BE:** implement database schema → `src/db/schema/`
  - [ ] **BE:** implement API endpoints → `src/`
  - [ ] **BE:** write unit and integration tests
  - [ ] **EM:** review and approve BE implementation

- [ ] **Frontend Development**
  - [ ] **FE:** implement UI components per approved mocks → `src/`
  - [ ] **FE:** integrate with API
  - [ ] **FE:** write component and end-to-end tests
  - [ ] **EM:** review and approve FE implementation

- [ ] **Infrastructure** *(skip if no new infrastructure)*
  - [ ] **DEVOPS:** provision infrastructure per approved architecture → `src/infra/`
  - [ ] **EM:** review and approve infrastructure

---

### Stage 5: Quality Assurance
> Skeleton -- EM refines these steps during Implementation Planning.

- [ ] **Test Planning**
  - [ ] **QA:** produce test plan aligned to API contract and implementation → `generated-docs/test-plan.md` + `generated-docs/test-plan.html`
  - [ ] **EM:** review and approve test plan

- [ ] **Test Execution**
  - [ ] **QA:** implement automated tests against BE
  - [ ] **QA:** implement automated tests against FE
  - [ ] **QA + BE:** resolve backend test blockers
  - [ ] **QA + FE:** resolve frontend test blockers
  - [ ] **EM:** review and approve test results

---

### Stage 6: Release

- [ ] **Phase Sign-off**
  - [ ] **EM:** verify all artifacts complete and approved, confirm deployment target is ready
  - [ ] 👤 **HUMAN:** review and approve release readiness

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
```
