/// "Anonymized data: 1 year" retention policy (Issue #94 scope item 1).
class ComputeAnalyticsRetentionExpiry {
  static const retentionPeriod = Duration(days: 365);

  static DateTime call(DateTime recordedAt) => recordedAt.add(retentionPeriod);
}
