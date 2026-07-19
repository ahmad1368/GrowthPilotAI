/// What action an ACTION_CARD message asks the recipient to take (Issue
/// #73) — mirrors the original issue's `actionType` field. [reviewAnomaly]
/// is the Issue #74 anomaly-alert card ("Ignore for this Merchant").
enum ActionCardType {
  approveTransaction,
  signContract,
  payInvoice,
  reviewAnomaly,
}
