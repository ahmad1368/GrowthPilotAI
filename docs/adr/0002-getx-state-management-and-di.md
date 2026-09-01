# 0002: GetX for state management and dependency injection

## Status
Accepted

## Context
A single-store, local-first app (ADR 0001) with dozens of independently
shippable features (each `/next-issue` PR is expected to be a self-contained
slice) needs a state-management approach that's consistent everywhere, low
ceremony to wire up per feature, and doesn't require a separate DI framework
bolted on top.

## Decision
GetX (`package:get`) is the single state-management and dependency-injection
mechanism across the app: `GetxController`/`GetxService` for state,
`Get.lazyPut(..., fenix: true)` in `lib/core/bindings/app_bindings.dart` for
registration, `Get.find<T>()` at call sites, `Obx(...)` for reactive UI, and
`GetMaterialApp`'s named routes (`Get.toNamed`) for navigation — including
route-level middleware (`ModuleAccessMiddleware`).

## Consequences
- One pattern to learn, and it's consistent across ~150+ controllers/services
  — a new feature's DI wiring looks the same as every other feature's.
- `fenix: true` (recreate on demand after disposal) is used everywhere by
  convention; forgetting it on a new registration is an easy, easy-to-miss
  mistake since the failure mode (a disposed controller silently not
  recreated) only shows up at runtime, not at compile time.
- Controllers/services that call `Get.find<ObjectBox>()` directly inside
  `onInit()` (the majority of them) aren't unit-testable in isolation without
  a live ObjectBox store — this repo's convention is accordingly to unit-test
  the underlying pure business-logic functions (`lib/business/`) instead of
  the GetX controllers themselves, and only give a controller a real
  interface-injected seam (like `WidgetLayoutController`'s
  `WidgetLayoutStore`) when it's already stateless/pure enough to justify one.
- Widgets that use `shadcn_ui` components need their own local `ShadTheme`
  ancestor (`ShadTheme(data: AppShadTheme.build(brightness), child: ...)`)
  since there's no global `ShadApp`/`ShadTheme` wrap in `main.dart` — a real
  gap in this convention that has caused at least one shipped crash bug
  (`SettingsScreen`/`SettingsPage`/`OmniPulseRadarView`, fixed in #189's PR)
  before it was caught.
