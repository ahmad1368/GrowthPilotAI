---
name: git-issues-compliance
description: Use this skill before implementing new features, modifying architecture, or refactoring code to ensure alignment with active Git issues and open roadmaps.
---

When developing or modifying code for GrowthPilotAI, you must code defensively against known bugs and future requirements detailed in the project's Git issues:

1. **Scan Git Issues/Context**: Check the relevant issues repository or project roadmap documentation before making foundational structural choices.
2. **Backward & Forward Compatibility**: Write clean interfaces and schemas so that integration with features marked as "upcoming" or "in-progress" in Git Issues requires zero refactoring of your current code.
3. **Documenting Limitations**: If your current code touches an area known to have an open Git Issue, add structured `// TODO (Issue #X):` comments directly in the file to guide future integration.
