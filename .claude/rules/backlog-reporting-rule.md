# Rule: Backlog Reporting

All agents must report tech debt and non-feature bugs discovered during any session by appending to the Triage section of `BACKLOG.md`. Use the `/backlog` skill for format and conventions.

## When to report

- A bug is observed or suspected (data, UI, API, infra, test)
- A shortcut or workaround was taken that should be revisited
- An implementation reveals a structural weakness not caused by the current task

## How to report

Append a row to the Triage table in `BACKLOG.md`:

| ID | Area | Type | Summary | Source | Date |
|----|------|------|---------|--------|------|
| (leave blank) | BE/FE/DB/Infra/Design/QA | bug/debt/ux | One-line description | Agent | today's date |

## Rules

- Never self-assign priority. Leave ID blank -- EM assigns at triage.
- Never move an item to Active. Triage only.
- Report even if the item seems minor. EM+PM decide what matters.
