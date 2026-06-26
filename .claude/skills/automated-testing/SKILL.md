---
name: automated-testing
description: Use this skill when asked to write tests, verify features, or create unit/bloc/widget test files in the test directory.
---

When generating test suites for GrowthPilotAI, ensure you strictly adhere to the following rules:

1. **Mocking Dependencies**: Use `mockito` or `mocktail` to mock repositories, network clients, and ObjectBox boxes. Never use real databases during unit tests.
2. **Bloc/Cubit Tests**: For state management testing, use the `bloc_test` package. Structure tests using the explicit `build`, `act`, and `expect` steps.
3. **Naming Convention**: Test files must reside in the `test/` directory, mirroring the exact folder structure of `lib/`, and must end with the `_test.dart` suffix.
4. **Group and Describe**: Organize test cases inside logical `group()` blocks with clear descriptions explaining the exact behavior being verified (e.g., "should emit [Loading, Success] when transaction is added").
