---
name: git-commits
description: Use this skill when asked to write commit messages, stage changes, create feature branches, or prepare Git logs.
---

When formatting Git operations for GrowthPilotAI, strictly follow the Conventional Commits specification:

1. **Commit Structure**: Write messages in the format: `<type>(<scope>): <description>`.
2. **Allowed Types**:
   - `feat`: A new feature for the user (e.g., `feat(wallet): add transaction sorting`).
   - `fix`: A bug fix (e.g., `fix(database): resolve objectbox lock on background thread`).
   - `docs`: Documentation only changes.
   - `style`: Changes that do not affect the meaning of the code (white-space, formatting).
   - `refactor`: A code change that neither fixes a bug nor adds a feature.
   - `test`: Adding missing tests or correcting existing tests.
3. **Imperative Mood**: Use the imperative, present tense in the description (e.g., "add charts" instead of "added charts" or "adds charts").
4. **Atomic Commits**: Keep changes isolated. Do not bundle multiple unrelated features or layers into a single message.
