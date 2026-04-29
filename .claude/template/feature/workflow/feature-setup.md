---
purpose: >
  Filled in by the human before any agent begins work.
  Configures which phases to include or skip and any deviations from the default collaboration pattern.
  Agents must read this before doing anything and use it to seed delivery-tracker.md.
---

# Project Config

## Project phases

The orchestrator reads this to seed `delivery-tracker.md`.

Toggle rules:
- `[ ]` -- active, include in the plan
- `[-]` -- skip. Apply to a stage to exclude all its steps -- no need to mark individual steps inside it. `[-]` is final: no agent may add, restore, or modify steps in a `[-]` stage. Only the human can change it.
- `💾` -- create a git commit automatically after this step completes, before moving on

---

### Stage 1: Discovery

- [ ] **Requirements Finalization**
  - [ ] **PM:** review PRD with human, surface open questions, confirm scope → [PRD]
  - [ ] 👤💾 **HUMAN:** review and approve PRD

---

### Stage 2: Design

- [ ] **UI / UX Design**
  - [ ] **DESIGNER:** produce mocks → [Mocks]
  - [ ] 👤💾 **HUMAN:** review and approve mocks

---

### Stage 3: Technical Planning

- [ ] **Engineering Kickoff**
  - [ ] **EM:** decide on architecture engagement → [Feature Setup]

- [ ] **System Architecture** *(skip if no new infrastructure or unfamiliar technology)*
  - [ ] **ARCH:** produce system architecture → [System Architecture]
  - [ ] 👤💾 **HUMAN:** review and approve system architecture

- [ ] **High-Level Design**
  - [ ] **EM:** produce high-level design → [Eng Plans (HLD)]
  - [ ] 👤💾 **HUMAN:** review and approve high-level design

- [ ] **Implementation Plan**
  - [ ] **EM:** produce detailed implementation plan, replace Stage 4 and Stage 5 skeleton steps with artifact-specific tasks; every step written must include a done condition (e.g. "done when: Status: Approved written to file" or "done when: human confirms")
  - [ ] 👤💾 **HUMAN:** review and approve implementation plan

---

### Stage 4: Engineering
> Skeleton -- EM fills in these steps during Implementation Planning, only if this stage is `[ ]`. If `[-]`, skip entirely and do not revisit.

- [ ] **BE Detailed Design**
  - [ ] **BE:** produce detailed design → [BE Detailed Design] -- done when: Status: Approved — EM set in file
  - [ ] 💾 **EM:** review and approve BE detailed design -- done when: Status: Approved — EM set in file

- [ ] **FE Detailed Design**
  - [ ] **FE:** produce detailed design → [FE Detailed Design] -- done when: Status: Approved — EM set in file
  - [ ] 💾 **EM:** review and approve FE detailed design -- done when: Status: Approved — EM set in file

- [ ] **API Contract**
  - [ ] **BE + FE:** align on API contract → [API Contract]
  - [ ] 💾 **EM:** review and approve API contract

- [ ] **BE Issues List**
  - [ ] **EM:** produce and approve BE issues list -- done when: Status: Approved — EM set in list; BE creates GH issues and begins implementation

- [ ] **Backend Development**
  - [ ] **BE:** implement database schema → [DB Schema Files]
  - [ ] 💾 **EM + BE:** review and approve DB schema -- done when: Status: Approved — EM set in schema file; blocks migrations and seed work
  - [ ] **BE:** implement API endpoints → `src/`
  - [ ] **BE:** write unit and integration tests
  - [ ] 💾 **EM:** review and approve BE implementation
  - [ ] **EM:** approve BE artifacts + test docs -- done when: Status: Approved noted; unblocks QA automation against BE

- [ ] **FE Issues List**
  - [ ] **EM:** produce and approve FE issues list -- done when: Status: Approved — EM set in list; FE creates GH issues and begins implementation

- [ ] **Frontend Development**
  - [ ] **FE:** implement UI components per approved mocks → `src/`
  - [ ] **FE:** integrate with API
  - [ ] **FE:** write component and end-to-end tests
  - [ ] 💾 **EM:** review and approve FE implementation
  - [ ] **EM:** approve FE artifacts + test docs -- done when: Status: Approved noted; unblocks QA automation against FE

- [ ] **Infrastructure** *(skip if no new infrastructure)*
  - [ ] **DEVOPS:** provision infrastructure per approved architecture → [Infrastructure]
  - [ ] 💾 **EM:** review and approve infrastructure

---

### Stage 5: Quality Assurance
> Skeleton -- EM fills in these steps during Implementation Planning, only if this stage is `[ ]`. If `[-]`, skip entirely and do not revisit.

- [ ] **Test Planning**
  - [ ] **QA:** produce test plan aligned to API contract and implementation → [Test Plan]
  - [ ] 💾 **EM:** review and approve test plan

- [ ] **QA Issues List**
  - [ ] **EM:** produce and approve QA issues list -- done when: Status: Approved — EM set in list; QA creates GH issues and begins implementation

- [ ] **Test Execution**
  - [ ] **QA:** implement automated tests against BE
  - [ ] **QA:** implement automated tests against FE
  - [ ] **QA + BE:** resolve backend test blockers
  - [ ] **QA + FE:** resolve frontend test blockers
  - [ ] 💾 **EM:** review and approve test results

---

### Stage 6: Release

- [ ] **Phase Sign-off**
  - [ ] **EM:** verify all artifacts complete and approved, confirm deployment target is ready
  - [ ] 👤💾 **HUMAN:** review and approve release readiness

---

### Stage 7: Master Baseline Update

> Always `[ ]` -- this stage is never skippable. Runs after Stage 6 sign-off and must complete before any new feature can begin.

- [ ] **PM:** merge this feature's PRD into `projects/master/product-specs/prd.md`
  - If master PRD exists: consolidate -- add new sections, update changed sections, do not duplicate
  - If master PRD is empty: copy feature PRD as-is
  - done when: master PRD reflects all shipped features including this one

- [ ] **DESIGNER:** merge this feature's mocks into `projects/master/mocks/`
  - If master mocks exist: add new pages, replace updated pages, remove obsolete pages
  - If master mocks are empty: copy feature mocks as-is
  - done when: master mocks reflect the current live UI across all shipped features

- [ ] 👤💾 **HUMAN:** confirm master is current

---

### Stage 8: README

> Always `[ ]` -- this stage is never skippable.

- [ ] **EM:** update `README.md` in repo root
  - If README exists: consolidate -- update project overview, add new features, update setup instructions if stack changed. Do not duplicate.
  - If README does not exist: create it.
  - Must include: project overview (1 paragraph), features list, prerequisites, how to run (BE and FE), how to run tests.
  - Keep it high-level and end-user facing. No internal agent/workflow details.
  - done when: README.md exists at repo root and reflects all shipped features

- [ ] 👤💾 **HUMAN:** review and approve README

---

## Deployment target

Declare the deployment intent for this project. Agents use this to determine whether DevOps/IaC work is in scope.

```
# Options: local | existing AWS infra | new AWS infra | TBD
local
```

---

## Additional context

Include anything that should inform delivery-tracker.md -- handwritten notes, whiteboard photos, Excalidraw diagrams, sketches, or rough ideas. Agents must respect and factor all of this in when generating delivery-tracker.md.

```
# Example:
- See product-specs/whiteboard-sketch.jpg for a rough flow diagram
- The team discussed keeping the data model flat -- avoid joins where possible
- The PM has a strong preference for shipping Phase 1 without auth; add auth in Phase 2
```
