/// [Issue #823] Shared vertical-stack layout for the app's persistent
/// floating icons — the "Financial Assistant" chat FAB (#200) and the
/// beta feedback FAB (#169) — so the two independent root overlays that
/// place them (which don't otherwise know about each other) can't drift
/// out of sync and end up overlapping or misaligned.
class FloatingFabLayout {
  // [Issue #796] Clears HomeLayout's floating bottom nav bar (20px margin
  // + ~56px bar height); harmless headroom on screens without the bar.
  static const double chatFabBottom = 96.0;
  static const double chatFabSize = 56.0;
  static const double stackGap = 12.0;

  /// Feedback FAB sits directly above the chat FAB in the same column.
  static const double feedbackFabBottom =
      chatFabBottom + chatFabSize + stackGap;
}
