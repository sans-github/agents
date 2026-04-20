# Getting Started

## Every feature

Run `/feature-init` in Claude Code. Claude will guide you through:
- Toggling phases on/off
- Setting the deployment target
- Capturing any additional context
- Gathering requirements (via PM agent) and writing the PRD
- Kicking off the workflow automatically

No manual file editing required. Claude produces `workflow/kickoff-plan.md` for your review and waits for your approval before any work begins.

---

## First-time setup

### Install

Copy agents, rules, skills, and templates into your project:

```bash
bash install.sh          # pull from main
bash install.sh v1.2.0   # pin a specific tag or branch
```

This overwrites everything under `.claude/` except `settings.json`. Commit the result to lock the version.

### Tech stack (optional)

Open [tech-config.md](tech-config.md) and update it to match your project: folder paths, naming conventions, tooling choices. Do this once after install and revisit when conventions change.

### Brand guidelines (optional)

A default brand is included at [skills/brand-guidelines/SKILL.md](skills/brand-guidelines/SKILL.md) (Off-White + Deep Teal, Plus Jakarta Sans, full light/dark token set). Preview it at [skills/brand-guidelines/previews/default-brand.html](skills/brand-guidelines/previews/default-brand.html).

To use your own: replace `SKILL.md` with your color palette, typography, spacing, and component states. Designer, FE, PM, and QA agents all read it before producing any UI work.

---

## How it works

```mermaid
flowchart LR
  subgraph once["🔧 One-time setup"]
    s1["1. Install<br/>(Eng · use script)"] --> s2["2. Review tech stack*<br/>(Eng)"] --> s3["3. Brand guidelines†<br/>(Design · PM)"]
  end
  subgraph feat["🔁 Per feature"]
    s4["4. /feature-init<br/>(Claude guides config, PRD + kickoff)"]
  end
  once --> feat
```

_* revisit when stack changes · † default included, replace to match your brand_
