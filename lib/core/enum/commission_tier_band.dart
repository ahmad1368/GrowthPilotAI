/// A merchant's cumulative-transaction-volume commission band (Issue
/// #425) — the platform's graduated commission schedule is priced per
/// band rather than a single flat rate.
enum CommissionTierBand { upTo100, upTo1000, over10000 }
