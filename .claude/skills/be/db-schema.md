---
name: db-schema
description: Database schema, migration, and seed conventions. Use when adding a DB layer, creating the initial schema, writing migration scripts, or seeding initial data.
---

# DB Schema and Migrations

## Directory structure

```
db/
├── schema/       # baseline table definitions, loaded once
├── migrations/   # additive changes after initial setup
└── seeds/
    ├── common/   # config/reference data, runs in all environments
    └── dev/      # fixture data, runs only in dev/staging
```

---

## Schema files (one-time setup)

Schema files define the baseline structure. They run once to create the initial tables, indexes, and constraints. **Never modify them after first run** -- all subsequent changes go through migrations.

Files are numbered to enforce load order (important when tables reference each other via foreign keys):

```
db/schema/
├── 01_users.sql
├── 02_roles.sql
├── 03_orders.sql
```

Use sequential numbers, not timestamps. The schema is a fixed baseline, not an evolving history.

---

## Migration scripts (additive changes)

Every schema change after initial setup is a migration. Migrations are:

- **Additive only** -- add columns, tables, indexes. Never drop or rename in the same script as a feature change
- **Never edited after merge** -- if a migration is wrong, write a new one to correct it
- **Run once per environment** -- the migration tool tracks which scripts have run and skips them on subsequent app starts

### File naming

```
YYYYMMDD_HHMMSS_<description>.sql
```

Examples:
```
db/migrations/
├── 20240315_143022_add_email_index_to_users.sql
├── 20240316_091500_add_phone_to_users.sql
```

The timestamp ensures global ordering and avoids conflicts when multiple branches introduce migrations simultaneously.

---

## Seed files (initial data)

Seeds populate configuration or reference data the system needs to operate. Like schema files, they are numbered and run once -- the migration tool tracks them separately so they are not re-applied on subsequent starts.

```
db/seeds/
├── 01_config_settings.sql
├── 02_lookup_codes.sql
```

Seeds are split by environment:

- `db/seeds/common/` -- config and reference data the system needs to operate in every environment (e.g. permission types, status codes, default settings). Always runs.
- `db/seeds/dev/` -- richer fixture data for local development and staging (e.g. sample users, demo content). **Never runs in production.**

The app (or migration tool) determines which folders to apply based on the current environment. Production applies `common/` only.

---

## App startup order

1. Run any pending schema files (in numeric order)
2. Run any pending seed files (in numeric order)
3. Run any pending migration files (in timestamp order)

Use a dedicated migration tool -- do not hand-roll the tracking logic:

| Ecosystem | Tool |
|-----------|------|
| JVM | Flyway, Liquibase |
| Python | Alembic, Yoyo |
| Node | node-pg-migrate, Knex, Prisma Migrate |
| Go | Goose, golang-migrate |
| Ruby | Active Record Migrations |

---

## Standard audit columns

Every table should include these columns unless there is a specific reason not to:

| Column | Type | Purpose |
|--------|------|---------|
| `id` | primary key | surrogate key (UUID or auto-increment) |
| `created_at` | timestamp with timezone | set on insert, never updated |
| `updated_at` | timestamp with timezone | updated on every write |
| `deleted_at` | timestamp with timezone (nullable) | soft delete -- null means active |

`deleted_at` is optional. If the system uses hard deletes, omit it. If soft deletes are used, all queries must filter `WHERE deleted_at IS NULL` by default.

Define these as part of the initial schema so they are consistent across all tables from the start.

---

## Index naming

Use a consistent naming pattern so indexes are predictable and searchable:

```
idx_{table}_{column(s)}
```

Examples:
```sql
CREATE INDEX idx_users_email ON users (email);
CREATE INDEX idx_orders_user_id_created_at ON orders (user_id, created_at);
```

For unique indexes:
```
uq_{table}_{column(s)}
```

Example:
```sql
CREATE UNIQUE INDEX uq_users_email ON users (email);
```

---

## Commit conventions

Follow [commit.md](commit.md). For DB work:

- Initial schema files: `add initial db schema #42`
- Each migration: its own commit, e.g. `add phone column to users #55`
- Each seed file: its own commit, e.g. `seed config settings table #61`
- Never bundle DB files with application code in the same commit
