---
name: rtl-localization
description: Use this skill when constructing UI screens, text fields, tables, forms, or formatting currency and dates for Iranian/Persian users.
---

When editing presentation or UI layers for GrowthPilotAI, ensure RTL and localization guidelines are respected:

1. **Directionality**: Use adaptive widgets or explicitly wrap Persian screens in a `Directionality(textDirection: TextDirection.rtl, ...)` if required.
2. **Currency Formatting**: Always format monetary amounts using the project's helper utility (e.g., adding Tomans/Rials separators) instead of printing raw integers.
3. **Fonts and Styling**: Apply the designated Persian font family (e.g., IRANSans, Vazirmatn) to the `TextStyle` object. Avoid default system fonts for Farsi text.
4. **Input Fields**: Ensure text alignment inside `TextField` updates contextually based on the language input (use `TextAlign.start` adaptively).
