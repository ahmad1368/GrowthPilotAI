/// Lifecycle of a peer-to-peer barter listing (Issue #413) —
/// [active] until a proposal is accepted ([matched], which represents
/// the offered item being locked in escrow), then [completed] once
/// both sides confirm resolution, or [cancelled] by the owner.
enum BarterListingStatus { active, matched, completed, cancelled }
