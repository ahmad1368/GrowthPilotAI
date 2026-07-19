/// Lifecycle of an ACTION_CARD message (Issue #73) — mirrors the original
/// issue's `status` field. [ignored] is the Issue #74 "Ignore for this
/// Merchant" false-positive dismissal. [snoozed] is the Issue #75
/// "Snooze" action on a Smart Recommendation card.
enum ActionCardStatus { pending, completed, expired, ignored, snoozed }
