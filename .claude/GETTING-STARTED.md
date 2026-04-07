# Getting Started

## 1. Install

Copy the latest agents, rules, and skills into your project:

```bash
bash scripts/sync.sh          # pull from main
bash scripts/sync.sh v1.2.0   # pin a specific tag or branch
```

This overwrites everything under `.claude/` (agents, rules, skills, template, guide docs) except your `settings.json`. Commit the result to lock the version.

---

## 2. Create a project folder

Each feature or initiative gets its own folder under `projects/`. Use the date + a short name:

```
projects/
└── YYYYMMDD-feature-name/
    ├── docs/           # all artifacts, flat, kebab-case (e.g. be-plan.md, api-contract.md)
    │   └── mockups/    # design mockups (HTML, images, Excalidraw)
    ├── requirements/   # raw inputs (Requirements.md, spreadsheets, sketches)
    └── workflow/
        ├── project-brief.md    # you fill this in before kicking off
        ├── phases.md           # EM generates; you review and approve
        └── phases-checklist.md # agent progress tracker
```

Copy the `.claude/template/` folder as your starting point:

```bash
cp -r .claude/template projects/YYYYMMDD-feature-name
```

---

## 3. Fill in project-brief.md

Before any agent starts work, fill in `workflow/project-brief.md`. This is the single place where you configure how the project runs -- which agents are active, which phases to skip, and any deviations from the default collaboration pattern.

You can also include handwritten notes, photos of whiteboard sketches, or links to Excalidraw diagrams in the **Additional context** section. Agents must respect and factor all of this into `phases.md`.

See the template for a complete example.

---

## 4. Kick off

With `project-brief.md` and `requirements/` in place, engage the starting agent defined in your brief -- typically PM for a new feature, EM for a tech-debt or refactor initiative. Point it at both files; it will read the brief, understand the workflow configuration, and begin from there.

The EM will generate `phases.md` once the PRD is ready. Review and approve it before agents proceed.
