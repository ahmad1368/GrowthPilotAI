---
name: responsive-design
description: Use this skill when constructing or modifying UI layout, pages, widgets, buttons, screens, and navigation bars to ensure cross-platform compatibility (Mobile, Tablet, Web).
---

When designing user interfaces for GrowthPilotAI, you must ensure the layout adapts beautifully across Mobile, Tablet, and Web viewports:

1. **Avoid Hardcoded Dimensions**: Never use fixed widths/heights for structural elements. Use `MediaQuery`, `LayoutBuilder`, or the project's responsive helper utilities.
2. **Breakpoints Implementation**: Classify viewports using these baseline standards:
   - Mobile: width < 600
   - Tablet: 600 <= width < 1200
   - Web/Desktop: width >= 1200
3. **Adaptive Form Factors**: Use `Flex`, `Wrap`, and `Grid` architectures instead of basic Rows/Columns so content flows naturally when resized on web browsers.
4. **Platform Input Safety**: Ensure buttons and input forms handle both touch interactions (Mobile/Tablet) and mouse/keyboard inputs (Web) seamlessly (e.g., hover states, correct mouse cursors). 5.**Use Flat Shadcn UI**: Use Flat Shadcn UI for project UI
