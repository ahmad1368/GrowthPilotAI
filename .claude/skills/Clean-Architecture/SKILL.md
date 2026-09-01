---
### ۲. اسکیل رعایت معماری لایه‌ای (Clean Architecture)
این اسکیل جلوی کلود را می‌گیرد تا کدهای منطق برنامه (Business Logic) یا کوئری‌های دیتابیس را درون فایل‌های UI و ویجت‌ها ننویسد.

**مسیر ایجاد فایل:** `.claude/skills/clean-architecture/SKILL.md`

```markdown
---

name: clean-architecture
description: Use this skill when implementing new features, modifying state management, creating repositories, or structuring files in the codebase.

---

GrowthPilotAI strictly follows Clean Architecture principles. When adding or updating code, enforce these strict layers:

1. **Data Layer (`lib/features/X/data/`)**: Contains Data Sources (ObjectBox queries), API providers, and Data Models. UI must NEVER access this layer directly.
2. **Domain Layer (`lib/features/X/domain/`)**: Contains pure business logic, UseCases, and abstract Repository definitions. It must remain independent of Flutter and UI frameworks.
3. **Presentation Layer (`lib/features/X/presentation/`)**: Contains State Management (Bloc/Cubit/Riverpod), Pages, and UI Widgets.
4. **Dependency Injection**: Registered new Repositories or Blocs into the global service locator (`get_it` or the project's chosen DI container). Do not instantiate dependencies locally inside widgets.
