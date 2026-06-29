---
name: objectbox-generator
description: Use this skill whenever creating, modifying, or deleting database entities, data models, or schemas using ObjectBox in Flutter.
---

When handling database tasks for GrowthPilotAI:

1. **Define Entities Correctly**: Ensure all data models in `lib/core/data/models/` or `entities/` use `@Entity()` and contain an `id = 0` field as required by ObjectBox.
2. **Trigger Code Generation**: Immediately after modifying any entity file, you MUST run the following command in the terminal to regenerate the database code:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
