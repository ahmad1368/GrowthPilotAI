/// "Freemium Data Policy" (Issue #215): data-usage consent is mandatory
/// for the free tier and optional (privacy-by-default) once a business
/// has an active premium subscription.
class IsDataUsageConsentRequired {
  static bool call(bool hasPremiumSubscription) => !hasPremiumSubscription;
}
