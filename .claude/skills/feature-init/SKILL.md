---
name: feature-init
description: Scaffold a new feature folder under projects/. Creates projects/master/ (once) and projects/YYYYMMDD-feature-name/ from the template. Use when starting work on a new feature.
argument-hint: 20260417-sample-feature
---

# Feature Init

Scaffolds a new feature workspace. Run when a consumer is ready to begin a new feature.

## Steps

1. Run `.claude/skills/feature-init/feature-init.sh` using Bash. It will prompt for a feature name and create the folder structure.
2. Show the user the output (folder tree) from the script.
3. Tell the user: "See `.claude/GETTING-STARTED.md` for next steps (stack config, brand guidelines, filling in project-config and prd, kickoff)."

Do not proceed further. The user takes over from here.
