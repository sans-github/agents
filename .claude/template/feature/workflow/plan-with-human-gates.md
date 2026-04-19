<!-- Seeded by the orchestrator at kickoff. Progressively filled by EM after step 10. -->
<!-- The orchestrator works through this top-to-bottom. When it runs out of steps, it stops. -->
<!-- 👤 = human gate. Human approves verbally, orchestrator checks the box. -->
<!-- **[ROLE]** = agent step. Named agent executes, orchestrator checks the box when complete. -->

## Kickoff

- [ ] 1. **[DESIGNER]** → produce mocks → `generated-docs/mocks/`
- [ ] 2. 👤 **[HUMAN]** → review and approve mocks before EM begins eng planning
- [ ] 3. **[EM]** → PM→EM handoff, evaluate arch engagement, record decision in `workflow/project-config.md`
- [ ] 4. **[ARCH]** → produce system architecture → `generated-docs/sys-arch.md` + `generated-docs/sys-arch.html` ← EM marks SKIPPED with rationale if arch not engaged
- [ ] 5. 👤 **[HUMAN]** → review and approve sys-arch before HLD begins ← EM marks SKIPPED if arch not engaged
- [ ] 6. **[EM]** → produce HLD → `generated-docs/hld.md` + `generated-docs/hld.html`
- [ ] 7. 👤 **[HUMAN]** → review and approve HLD before detailed design begins
- [ ] 8. **[EM]** → produce detailed implementation plan, add remaining phases to this doc
- [ ] 9. 👤 **[HUMAN]** → review and approve implementation plan before execution begins

<!-- EM fills in remaining phases progressively from here (detailed design, API contract, -->
<!-- implementation, QA, phase close). -->
