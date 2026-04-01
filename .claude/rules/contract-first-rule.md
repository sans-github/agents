# Rule: Contract-First Dependencies

No role -- agent or human -- may begin work that depends on an upstream artifact until that artifact is explicitly approved. This prevents rework and wasted effort caused by building on an unstable or unreviewed foundation.

## Canonical contracts

| Upstream artifact | Owner | Downstream roles blocked until approved |
|---|---|---|
| PRD | PM | Designer (mocks, prototypes, flows) |
| DB schema | EM + BE | BE (data layer, migrations, queries) |
| API contract | EM + BE + FE | BE (endpoint implementation), FE (integration) |

This list is not exhaustive. The same principle applies to any dependency between roles: if your work would need to be redone when an upstream artifact changes, treat it as a contract and require approval before starting.

## What "approved" means

An artifact is approved when:

1. It has a `Status: Approved` line in its frontmatter or at the top of the file, with the approving role noted (e.g. `Status: Approved — EM`).
2. The corresponding approval step in `PHASES-CHECKLIST.md` is checked off.

Both must be present. One without the other is not sufficient.

## Adding approval to an artifact

At the top of the document, before content:

```
Status: Approved — EM
Approved: 2026-04-01
```

## Adding an approval step to the checklist

Every contract must have an explicit approval step in `PHASES-CHECKLIST.md`:

```markdown
- [ ] 3. EM approves DB schema (`db/schema.md` Status set to Approved)
```

This step must appear before any downstream implementation steps that depend on it.

## When a contract is not yet approved

Stop immediately. Do not do speculative work. Surface the blocker clearly:

> Blocked: waiting for [artifact name] to be approved by [role]. No downstream work will proceed until `Status: Approved` is set and the checklist step is checked off.

Do not draft a substitute, make assumptions about what the contract will say, or begin work on parts that "probably won't change." Wait for the real approval.
