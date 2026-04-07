# Rule: Master PRD and Mocks

A consolidated, up-to-date copy of the full product PRD and HTML mocks must be maintained at `projects/master/`. This is the baseline every new feature starts from.

## Structure

```
projects/
└── master/
    ├── prd.md       # full product PRD, merged across all shipped features
    └── mockups/     # current HTML mocks reflecting the live product UI
```

## When to update

`projects/master/` must stay current throughout development -- not just at phase close:

- **PM** updates `projects/master/prd.md` whenever the PRD evolves during a phase (scope changes, AC revisions, requirement clarifications)
- **Designer** updates `projects/master/mockups/` whenever mocks are revised during a phase
- Both must also update at phase close, in the same commit as EM sign-off

Do not let the master fall behind the working feature. Update it as changes happen.

## QA gate

QA compares the working product against `projects/master/prd.md` and `projects/master/mockups/` during validation:

- If a UI element differs from the mocks -- file a GH issue, assign to Designer to update the mocks or flag the discrepancy to PM
- If product behavior differs from the PRD -- file a GH issue, assign to PM to update the PRD or confirm the change is intentional

QA does not resolve these discrepancies. They surface them. PM and Designer decide whether the product or the spec is wrong and update accordingly.

## Hard block on new features

PM and Designer must not begin work on a new feature until `projects/master/` is current:

- PM must confirm `projects/master/prd.md` reflects all previously shipped phases before authoring a new PRD
- Designer must confirm `projects/master/mockups/` is current before creating new mocks

If the master is stale, update it first. Do not use a feature-specific PRD or mock as the baseline -- always use `projects/master/`.

## Ownership

- **PM** owns `projects/master/prd.md`
- **Designer** owns `projects/master/mockups/`
- **EM** verifies both are updated as part of phase sign-off
