---
name: collaboration-contracts
description: Single source of truth for all agent collaboration contracts -- what each role depends on, produces, and gatekeeps across all delivery phases. Update this file when any artifact flow, dependency, or approval gate changes. All agents load this at runtime.
---

# Collaboration Contracts

This is the single source of truth for artifact flows across the team. When a collaboration model changes, update this file only -- do not update individual agent files.

---

## PM <> User

**PM depends on:**
- Reqs -- gathered from User before authoring PRD

**PM produces:**
- `prd.md` -- single document covering PRD, app flows, ACs, and risks; PM is gatekeeper

---

## PM <> Designer

**PM provides to Designer:**
- PRD, ACs -- approved by PM; triggers Mock creation

**Designer provides to PM:**
- Mocks (draft) -- iterated until PM approves

**PM produces (joint with Designer):**
- Mocks -- PM is gatekeeper; not final until PM sets `Status: Approved`

---

## PM <> EM

**PM provides to EM:**
- PRD, Reqs, Mocks, ACs -- after Mocks are approved; kicks off engineering planning

**EM depends on:**
- PRD, ACs -- approved by PM before authoring Eng Plans (HLD)

---

## PM <> QA

**PM provides to QA:**
- PRD, Mocks, ACs -- input to Test Plan authoring (sent when available, before Eng Planning)

**QA depends on from PM:**
- PRD, Mocks, ACs -- provided by PM before authoring Test Plan

---

## PM <> BE / FE

**PM provides to BE, FE:**
- PRD, Reqs, Mocks, ACs -- single source of truth for scope and acceptance criteria

---

## EM <> Arch

**EM provides to Arch:**
- PRD, ACs -- to scope Sys Arch

**Arch provides to EM:**
- Sys Arch (`generated-docs/sys-arch.md` + `generated-docs/sys-arch.html`) -- EM drives the loop; Arch authors and has final say; in agent-to-agent handoffs pass only the `.md` file

**EM depends on:**
- Sys Arch -- approved by Arch before authoring Eng Plans (HLD)
- Arch approval -- any new tech stack or AWS component EM wants to include in HLD requires Arch sign-off first

---

## EM <> BE

**EM provides to BE:**
- Eng Plans (HLD) -- approved by EM; unblocks BE Detailed Design

**BE provides to EM:**
- BE Detailed Design (`generated-docs/be-detailed-design.md` + `generated-docs/be-detailed-design.html`) -- for approval; in agent-to-agent handoffs pass only the `.md` file
- Issues List -- submitted for sign-off before GH Issues are created

**EM gatekeeps:**
- BE Detailed Design -- must be approved before BE API implementation or API Contract authoring
- Issues List (BE) -- must be approved before GH Issues are created and implementation begins

**BE depends on:**
- Arch approval -- any new tech stack or AWS component BE wants to introduce requires Arch sign-off before it can be included in BE Detailed Design
- Eng Plans (HLD) -- approved by EM before authoring BE Detailed Design
- BE Detailed Design -- approved by EM before authoring API Contract or beginning implementation
- Issues List -- approved by EM before creating GH Issues and beginning implementation

---

## EM <> FE

**EM provides to FE:**
- Eng Plans (HLD) -- approved by EM; unblocks FE Detailed Design

**FE provides to EM:**
- FE Detailed Design (`generated-docs/fe-detailed-design.md` + `generated-docs/fe-detailed-design.html`) -- for approval; in agent-to-agent handoffs pass only the `.md` file
- Issues List -- submitted for sign-off before GH Issues are created

**EM gatekeeps:**
- FE Detailed Design -- must be approved before FE implementation or API Contract authoring
- Issues List (FE) -- must be approved before GH Issues are created and implementation begins

**FE depends on:**
- Arch approval -- any new tech stack or library FE wants to introduce requires Arch sign-off before it can be included in FE Detailed Design
- Eng Plans (HLD) -- approved by EM before authoring FE Detailed Design
- Mocks -- approved by PM before beginning component implementation
- FE Detailed Design -- approved by EM before authoring API Contract or beginning implementation
- Issues List -- approved by EM before creating GH Issues and beginning implementation

---

## BE <> FE

**Joint output:**
- API Contract -- authored jointly by BE and FE, aligned on their Detailed Designs; submitted to EM for approval

**EM gatekeeps:**
- API Contract -- must be approved before BE endpoint implementation and FE integration begin

**BE and FE each depend on:**
- API Contract -- approved by EM before implementing endpoints (BE) or implementing integration (FE)

---

## EM <> QA

**EM provides to QA:**
- BE + FE Detailed Designs -- forwarded by EM once approved; input to Test Plan authoring

**QA provides to EM:**
- Test Plan -- for approval before Issues List authoring
- Issues List -- submitted for sign-off before GH Issues are created
- Automation suite -- for approval before delivery

**EM gatekeeps:**
- Test Plan -- must be approved before QA Issues List authoring
- Issues List (QA) -- must be approved before GH Issues are created and automation begins

**QA depends on:**
- PRD, Mocks, ACs -- provided by PM before authoring Test Plan
- BE Detailed Design + FE Detailed Design -- approved and forwarded by EM before beginning detailed QA planning
- Test Plan -- approved by EM before authoring Issues List
- Issues List -- approved by EM before creating GH Issues and beginning implementation

---

## BE <> QA

**BE provides to QA:**
- BE Artifacts + BE Test Docs -- required before QA can author BE automation

**QA depends on from BE:**
- BE Artifacts + BE Test Docs -- received from BE before authoring BE automation

---

## FE <> QA

**FE provides to QA:**
- FE Artifacts + FE Test Docs -- required before QA can author FE automation

**QA depends on from FE:**
- FE Artifacts + FE Test Docs -- received from FE before authoring FE automation

**QA produces (from BE + FE combined):**
- Automation suite -- gated by EM
- Spec drift GH issues -- filed to PM when PRD differs from working product; to Designer when mocks differ

---

## Designer <> FE

**Designer provides to FE:**
- Mocks (approved) -- input to component implementation; handed off after PM approves

**FE depends on from Designer:**
- Mocks -- approved by PM before beginning component implementation

---

## EM <> DevOps

**EM provides to DevOps:**
- Eng Plans (HLD) -- approved by EM; unblocks infrastructure provisioning

**DevOps provides to EM:**
- IaC (Terraform) -- EM is gatekeeper for high-risk or cost-significant changes
- CI/CD pipelines -- EM is gatekeeper for high-risk or cost-significant changes

**DevOps depends on:**
- Arch approval -- any new AWS component or infrastructure service DevOps wants to introduce requires Arch sign-off before provisioning
- Eng Plans (HLD) -- approved by EM before provisioning infrastructure
- Any high-risk or cost-significant infra change -- requires explicit EM approval before proceeding

---

## DevOps <> BE / FE

**DevOps provides to BE, FE:**
- Deployment targets, environment configs, runbooks -- enables implementation

**DevOps provides to QA:**
- CI gates -- test suites wired into pipeline before QA begins automation

---

## Arch gatekeeping

Arch must approve before any role proceeds with a new tech stack or AWS component.

**Gatekeeps (must approve before downstream proceeds):**
- Tech stack adoption -- any new language, framework, or major library proposed by EM, BE, or FE requires Arch approval before use
- AWS component adoption -- any new AWS service or infrastructure component proposed by EM, BE, FE, or DevOps requires Arch approval before provisioning

---

## EM produces (standalone)

- Plan with Human Gates (`workflow/plan-with-human-gates.md`) -- progressively filled by EM; seeded at kickoff with initial steps up to PM→EM handoff; after handoff, EM adds arch steps (if needed), HLD, and then the detailed implementation plan (full phase-by-phase breakdown with numbered steps, responsible agents, artifacts, loop exit conditions, and human checkpoints); always add a 👤 human gate after the implementation plan before execution begins; the orchestrator works through it top-to-bottom and stops when it reaches the end, waiting for EM to add the next batch
- Eng Plans (HLD) -- delivered as two files: `generated-docs/hld.md` (source of truth) and `generated-docs/hld.html` (self-contained, inline CSS, no external dependencies, renders diagrams and tables for stakeholder review); EM is gatekeeper
