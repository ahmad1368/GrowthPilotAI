/// A location-based prompt (Issue #201's "Location Data... suggest
/// 'Analyze my spending in Surrey'"). Null when there's no dominant
/// city yet (caller has no local location data).
class BuildLocationPrompt {
  static String? call(String? topCity) {
    if (topCity == null) return null;
    return 'Analyze my spending in $topCity';
  }
}
