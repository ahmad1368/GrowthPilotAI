---
name: performance-optimization
description: Use this skill when creating custom widgets, rendering large lists, working with streams, or optimizing UI performance.
---

To maintain optimal performance across GrowthPilotAI, strictly enforce these rules:

1. **Const Constructors**: Maximize the use of `const` constructors for widgets to leverage Flutter's caching mechanism.
2. **Efficient Lists**: Always use `ListView.builder` or `SliverList` instead of a default `ListView` for long data arrays like transaction history to enable lazy loading.
3. **Stream and Controller Disposal**: Ensure all `StreamSubscription`s, `TextEditingController`s, and `ChangeNotifier`s are properly closed or canceled in the `dispose()` method of `StatefulWidget`s or equivalents to prevent memory leaks.
4. **Repaint Boundaries**: Wrap highly dynamic or heavy UI elements (like animated charts or financial graphs) in a `RepaintBoundary` to isolate paint operations.
