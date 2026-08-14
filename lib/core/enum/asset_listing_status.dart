/// Lifecycle of a rapid liquidation asset listing (Issue #412) —
/// [pendingReview] until admin screening (#412 acceptance criterion
/// 4), then [active] until a bid is accepted ([sold]) and pickup is
/// confirmed ([completed]).
enum AssetListingStatus { pendingReview, active, rejected, sold, completed }
