/// Looks up a term's plain-English definition (Issue #164) — a missing
/// `termKey` returns null instead of throwing, so a typo or a term not
/// yet added to the dictionary just hides the tooltip rather than
/// crashing the screen it's attached to.
class LookupHelpDefinition {
  static String? call(Map<String, String> definitions, String termKey) => definitions[termKey];
}
