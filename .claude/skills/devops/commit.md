---
name: commit-devops
description: Commit conventions for the DevOps Engineer role
---

- Commit after each discrete unit of work; no batching unrelated changes
- No WIP commits -- every commit must leave infra in a deployable state
- Short, specific subject in imperative mood with issue reference (e.g. `add autoscaling to ECS service #55`)
- Separate infra changes from app config changes; never bundle Terraform and application code in one commit
- Include `terraform plan` resource summary in the commit body for any resource-affecting change
- Tag destructive commits clearly so reviewers can assess rollback safety (e.g. `remove redis cluster #45`)
