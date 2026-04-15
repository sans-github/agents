# Conventions Reference

One-stop reference for key decisions baked into this repo's rules and skills. When you adopt this library, these are the paths and conventions your project inherits.

---

## Tech stack

Update this to match your project. The kickoff prompt reads this section to evaluate stack fit.

| Layer | Technology |
|-------|------------|
| BE | Java 21 + Spring Boot (REST API, Spring Data JPA + Hibernate 6, H2 for dev/test, PostgreSQL/MySQL for prod) |
| FE | React 18 + TypeScript (Redux Toolkit, TanStack Query, React Router v6, Vite) |
| Infra | Terraform on AWS |
| QA | Playwright (E2E + API) |

---

## File locations

| Artifact | Path | Owner | Source |
|---|---|---|---|
| System architecture | `docs/sys-arch.md` + `docs/sys-arch.html` | Arch writes, EM approves | `senior-software-architect.md` |
| Eng Plans (HLD) | `docs/hld.md` + `docs/hld.html` | EM writes, EM approves | `senior-engineering-manager.md` |
| ER diagram | `db/er-diagram.md` | BE writes, EM verifies | `er-diagram-rule.md` |
| DB schema files | `db/schema/` | BE | `db-schema.md` |
| DB migrations | `db/migrations/` | BE | `db-schema.md` |
| DB seeds (all envs) | `db/seeds/common/` | BE | `db-schema.md` |
| DB seeds (dev only) | `db/seeds/dev/` | BE | `db-schema.md` |
| Tech debt / bug backlog | `BACKLOG.md` | EM triages | `backlog-reporting-rule.md` |
| Human milestone gates | `workflow/human-checkpoints.md` | Seeded at kickoff; human checks off | `contract-first-rule.md` |
| Phase progress / agent checklist | `workflow/implementation-plan.md` | EM authors; agents check off steps | `progress-tracking-rule.md` |
| Workflow definition | `workflow/` | EM | `workflow-phases-rule.md` |

---

## Contract approvals

Agent-to-agent technical contracts that block downstream work until approved. Approval requires a `Status: Approved — [role]` header at the top of the file. Human milestone gates (PRD, Mocks, Sys Arch, Implementation Plan) are defined per-project in `workflow/human-checkpoints.md`.

| Artifact | Approver | Blocks |
|---|---|---|
| PRD | PM | Designer (mocks, flows) |
| DB schema | EM + BE | BE data layer, migrations, queries |
| API contract | EM + BE + FE | BE endpoint implementation, FE integration |

---

## DB conventions

| Convention | Value |
|---|---|
| Migration filename format | `YYYYMMDD_HHMMSS_<description>.sql` |
| Schema files | Numbered (`01_users.sql`), run once, never modified after first run |
| Column naming | snake_case (e.g. `created_at`, `user_id`, `order_total`) |
| ID type | UUID |
| Audit columns | `id`, `created_at`, `updated_at`, `deleted_at` on every table |
| Index naming | `idx_{table}_{column}`, unique: `uq_{table}_{column}` |
| FK naming | `{referenced_table}_id` by default; role-based (e.g. `customer_id`) when two FKs reference the same table |

---

## ER diagram format

Mermaid `erDiagram` syntax. Must be updated in the same commit as any schema change.

---

## Code style

| Convention | Value |
|---|---|
| Linter | Checkstyle with `google_checks.xml` |
| Coverage | 100% line coverage enforced via JaCoCo |
| Maven phase | `verify` -- `mvn verify` fails on Checkstyle violations or coverage below 100% |
| CI gate | GitHub Actions runs `mvn verify` on every PR, blocks merge on failure |

---

## Backlog

All agents append to the Triage table in `BACKLOG.md`. ID and priority are assigned by EM at triage -- never self-assigned.
