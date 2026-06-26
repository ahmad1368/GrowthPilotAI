---
name: error-handling
description: Use this skill when writing asynchronous code, API requests, database queries, or handling application-wide exceptions.
---

When implementing error handling or async loops in GrowthPilotAI:

1. **No Raw Prints**: Never use raw `print()` statements for errors. Use the project's designated logger utility (e.g., `developer.log` or a custom Logger class).
2. **Database Exceptions**: Always wrap ObjectBox operations (especially transactions and writes) in `try-catch` blocks catching `ObjectBoxException` or generic `Exception`.
3. **UI Feedback**: Ensure exceptions caught in the presentation layer are translated into user-friendly UI messages (e.g., via a SnackBar or custom error state in Bloc/Riverpod) rather than crashing the app or showing raw codes.
4. **Fallback Values**: Provide safe default or fallback values when a database query or safe-parsing fails.
