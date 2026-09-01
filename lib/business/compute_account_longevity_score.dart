/// "Longevity/Identity" weight input (Issue #135) — normalizes account
/// age against a one-year "mature account" baseline. KYC status (#144)
/// isn't built yet, so identity verification isn't factored in here.
class ComputeAccountLongevityScore {
  static const matureAccountAge = Duration(days: 365);

  static double call(DateTime accountCreatedAt, DateTime now) {
    final age = now.difference(accountCreatedAt);
    if (age.isNegative) return 0.0;
    return (age.inDays / matureAccountAge.inDays).clamp(0.0, 1.0);
  }
}
