/// Canonical funnel/feature event names (Issue #194) — logged via the
/// existing #539 `RecordLocalUsageEvent` (`UsageEventType.actionCompleted`)
/// instead of Firebase Analytics/GA4 (no such account exists in this
/// repo; see PR notes). snake_case to match Firebase's own event-name
/// convention, in case this ever needs to map onto a real provider.
class FunnelEventNames {
  static const signUpStart = 'sign_up_start';
  static const signUpComplete = 'sign_up_complete';
  static const invoiceScannedSuccess = 'invoice_scanned_success';
  static const marketplaceMatchViewed = 'marketplace_match_viewed';
  static const premiumUpgradeInitiated = 'premium_upgrade_initiated';
  static const foundingMemberClaimed = 'founding_member_claimed';

  /// Funnel order for `SummarizeFunnelEvents` (Issue #194's "Install ->
  /// Onboarding -> First Scan -> Subscription").
  static const funnelOrder = [signUpStart, signUpComplete, invoiceScannedSuccess, premiumUpgradeInitiated];
}
