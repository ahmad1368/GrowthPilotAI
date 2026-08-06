/// Lifecycle of a group-buying campaign (Issue #414) — [open] while
/// merchants are contributing toward the quantity threshold, then
/// [finalized] once the organizer locks in the consolidated bulk
/// order. Expiry (deadline passed without meeting the threshold) is a
/// derived state, not a persisted one — see [IsGroupPurchaseExpired].
enum GroupPurchaseStatus { open, finalized }
