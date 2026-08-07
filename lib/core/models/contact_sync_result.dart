/// Outcome of one contact-sync pass (Issue #541, acceptance criteria
/// 3-4) — only display names are ever surfaced for matches; raw
/// identifiers never leave the client-side hashing step.
class ContactSyncResult {
  final List<String> matchedNames;
  final List<String> unmatchedIdentifiers;

  const ContactSyncResult({required this.matchedNames, required this.unmatchedIdentifiers});
}
