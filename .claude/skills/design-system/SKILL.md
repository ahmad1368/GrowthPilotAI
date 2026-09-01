---
name: design-system
description: Use this skill when building UI elements, buttons, text fields, cards, custom themes, or layout components to enforce the project's standard UI framework.
---

To maintain strict visual consistency across GrowthPilotAI, do not create raw or ad-hoc UI elements. Always reuse the established design system framework:

1. **Use Pre-existing Components**: Before writing a new UI component (e.g., a custom wallet card or custom button), inspect the `lib/core/presentation/widgets/` directory and extend or reuse existing foundational widgets.
2. **Theme Access**: Restrict hardcoded color codes (Hex) or fonts inside pages. Always read properties from the centralized design system theme context: `Theme.of(context).extension<CustomTheme>()` or standard `Theme.of(context).colorScheme`.
3. **Typography Mapping**: Use specified `TextTheme` definitions (e.g., `bodyLarge`, `titleMedium`) with predefined weights rather than declaring separate font sizes manually in every widget.
