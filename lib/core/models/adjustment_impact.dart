/// One commission-rate admin adjustment's before/after impact on a
/// merchant's estimated retained earnings (Issue #349, acceptance
/// criteria 1-2) — derived from the audit trail (#343) rather than a
/// new profitability dataset, since this app has no per-merchant
/// revenue ledger.
class AdjustmentImpact {
  final String merchantName;
  final double previousRatePercent;
  final double newRatePercent;
  final double impactPercent;
  final DateTime timestamp;

  const AdjustmentImpact({
    required this.merchantName,
    required this.previousRatePercent,
    required this.newRatePercent,
    required this.impactPercent,
    required this.timestamp,
  });
}
