/// Lifecycle of a programmatic escrow account (Issue #415, acceptance
/// criterion 1) — [held] until the buyer confirms delivery
/// ([released]) or files a claim, which either auto-resolves to
/// [refunded] or, for an ambiguous reason, escalates to [disputed]
/// pending admin resolution.
enum EscrowStatus { held, released, refunded, disputed }
