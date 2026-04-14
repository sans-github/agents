# Rule: Contract-First Dependencies

No role -- agent or human -- may begin work that depends on an upstream artifact until that artifact is explicitly approved. This prevents rework and wasted effort caused by building on an unstable or unreviewed foundation.

## Canonical contracts

| Upstream artifact | Approver | Downstream work blocked |
|---|---|---|
| Kickoff plan (`workflow/kickoff-plan.md`) | Human | No agent may begin any work -- no PRD, no mocks, no planning, nothing -- until the human explicitly approves the kickoff plan |
| Tech stack / AWS component adoption | Arch | Proposing role (EM, BE, FE, DevOps) cannot include it in any artifact or begin provisioning |
| Reqs | -- | PM cannot produce PRD |
| PRD, ACs | PM | Design (Mocks); EM (Eng planning) |
| Mocks | PM | EM planning that depends on UI shape |
| Sys Arch (`sys-arch.md` + `sys-arch.html`) | Arch | EM (Eng Plans / HLD) |
| Implementation Plan (`workflow/implementation-plan.md`) | Human | No phase execution, no detailed design, no agent begins work until human approves |
| Eng Plans (HLD) (`hld.md` + `hld.html`) | EM | BE (Detailed Design), FE (FE Arch) |
| BE Detailed Design | EM | BE API implementation, BE<>FE contract |
| FE Arch | EM | FE component implementation, BE<>FE contract |
| API Contract | EM | BE endpoint implementation, FE integration |
| Test Plan | EM | QA Issues List, automation work |
| Issues List (BE) | EM | BE creates GH Issues and begins implementation |
| Issues List (FE) | EM | FE creates GH Issues and begins implementation |
| Issues List (QA) | EM | QA creates GH Issues and begins implementation |
| BE Artifacts + BE Test Docs | EM | QA automation against BE |
| FE Artifacts + FE Test Docs | EM | QA automation against FE |

## What "approved" means

An artifact is approved when:

1. It has a `Status: Approved` line in its frontmatter or at the top of the file, with the approving role noted (e.g. `Status: Approved — EM`).
2. The corresponding approval step in `implementation-plan-tracker.md` is checked off.

Both must be present. One without the other is not sufficient.

## Adding approval to an artifact

At the top of the document, before content:

```
Status: Approved — EM
Approved: 2026-04-01
```

## Adding an approval step to the checklist

Every contract must have an explicit approval step in `implementation-plan-tracker.md`:

```markdown
- [ ] 3. EM approves DB schema (`db/schema.md` Status set to Approved)
```

This step must appear before any downstream implementation steps that depend on it.

## Kickoff plan checkpoints are contracts

Every checkpoint listed in section 5 of the kickoff plan (`workflow/kickoff-plan.md`) is a binding contract. When an agent completes work that produces a checkpoint artifact, it must:

1. Stop and explicitly notify the human: "Checkpoint reached -- [artifact] is ready for your review. No work will proceed until you approve."
2. Wait for the human to verbally confirm (e.g. "looks good", "approved", "proceed"). The human does not edit files. After the human confirms, the orchestrating agent writes `Status: Approved — [role]` and `Approved: YYYY-MM-DD` into the artifact file before proceeding.
3. Run `git diff --stat HEAD` to see what has changed. Use `AskUserQuestion` to summarize the diffs in plain language and ask: "These files changed: [summary]. Want to commit before we move on?" If yes, invoke the `/my-git-commit` skill and wait for it to complete.
4. Only then proceed to the next step.

Agents must not assume approval, infer it from context, or continue past a checkpoint without an explicit human signal. If the human has not responded, the agent stays stopped.

## When a contract is not yet approved

Stop immediately. Do not do speculative work. Surface the blocker clearly:

> Blocked: waiting for [artifact name] to be approved by [role]. No downstream work will proceed until `Status: Approved` is set and the checklist step is checked off.

Do not draft a substitute, make assumptions about what the contract will say, or begin work on parts that "probably won't change." Wait for the real approval.
