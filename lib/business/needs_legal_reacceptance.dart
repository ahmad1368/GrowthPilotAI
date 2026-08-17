/// The "Legal Versioning" guard predicate (Issue #215) — whether the
/// user's accepted terms version is missing or outdated compared to the
/// current published version. No NestJS Guard exists to enforce this
/// server-side (see PR notes); this is the client-side check a route
/// guard would apply.
class NeedsLegalReacceptance {
  static bool call(String? acceptedVersion, String currentVersion) {
    return acceptedVersion != currentVersion;
  }
}
