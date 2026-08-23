# 0003: Flat shadcn_ui design system, retiring Glassmorphism

## Status
Accepted (supersedes an earlier, now-retired Glassmorphism direction)

## Context
Earlier in the project's history, the UI direction was Glassmorphism:
`OmniGlassPanel`/`BackdropFilter`-based frosted-glass panels, plus custom
typography widgets (`AdaptiveText`) and other bespoke components
(`OmniAlertDialog`, `omni_button.dart`, `glass_app_bar.dart`). A number of
still-open, auto-generated issues (including #184 itself, #188, #190) were
written against that older direction and reference it explicitly. The
product moved to a flat, minimal visual language instead (in the style of
OpenAI/Claude/Vercel), for consistency and to avoid `BackdropFilter`'s
real, measurable rendering-performance cost on lower-end Android hardware.

## Decision
All new UI work uses `shadcn_ui` components directly (`ShadButton`,
`ShadSwitch`, `ShadInput`, `ShadDialog`, `ShadTheme`) with a fixed flat
palette — dark background `#09090b` / card `#18181b`, light background
`#ffffff` / card white with a soft shadow, `withValues` instead of the
deprecated `withOpacity`. `OmniGlassPanel`, `AdaptiveText`, `OmniAlertDialog`,
`OcrActionButtons`, `omni_button.dart`, and `glass_app_bar.dart` are banned
in new code; when one is encountered directly on the path of an unrelated
change, it gets replaced inline, not worked around.

## Consequences
- The app is visually inconsistent today: dozens of legacy screens
  (`lib/pages/settings_page.dart`, `lib/widgets/insight_card.dart`, large
  parts of `lib/screens/settings_screen.dart`) still render Glassmorphism
  and `AdaptiveText` side by side with newer flat shadcn_ui screens. This is
  deliberate, tracked debt — full-screen rewrites are out of scope for
  feature PRs that only touch one section of a legacy file; each PR notes
  what it left untouched rather than silently expanding scope.
- Some open backlog issues (auto-generated before this decision) still ask
  for Glassmorphism-specific deliverables (e.g. #188's screenshot spec,
  #190's `frame_screenshots`). Those requirements are treated as stale
  against this ADR, not followed literally.
- `shadcn_ui` needs a local `ShadTheme` ancestor per screen (see ADR 0002's
  consequences) — an easy thing to forget when adding a shadcn_ui widget to
  a screen that's never used one before.
