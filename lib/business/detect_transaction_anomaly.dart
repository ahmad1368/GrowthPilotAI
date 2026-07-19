import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/models/transaction_anomaly.dart';
import 'package:growth_pilot_ai/core/utils/anomaly_detector.dart';

/// Flags a newly-synced transaction as an anomaly (Issue #74): a 3-sigma
/// Z-score outlier against its category's rolling history, or [_velocityLimit]
/// same-merchant charges within [_velocityWindow] (duplicate-billing guard).
/// Returns null when neither trigger fires or [ignoredMerchants] has
/// suppressed this merchant ("Ignore for this Merchant").
class DetectTransactionAnomaly {
  static const double _zScoreThreshold = 3.0;
  static const int _minBaseline = 10;
  static const int _velocityLimit = 3;
  static const Duration _velocityWindow = Duration(hours: 24);

  static TransactionAnomaly? call({
    required String transactionRefId,
    required String merchantName,
    required double amount,
    required List<double> categoryHistory,
    required List<DateTime> recentMerchantCharges,
    required DateTime now,
    Set<String> ignoredMerchants = const {},
  }) {
    if (ignoredMerchants.contains(merchantName)) return null;

    final burstCount = recentMerchantCharges
        .where((chargedAt) => now.difference(chargedAt) <= _velocityWindow)
        .length;
    if (burstCount >= _velocityLimit) {
      return TransactionAnomaly(
        type: AnomalyType.velocity,
        transactionRefId: transactionRefId,
        merchantName: merchantName,
        amount: amount,
      );
    }
    if (categoryHistory.length < _minBaseline) return null;
    final z = AnomalyDetector.zScore(amount, categoryHistory);
    if (z <= _zScoreThreshold) return null;

    return TransactionAnomaly(
      type: AnomalyType.zScore,
      transactionRefId: transactionRefId,
      merchantName: merchantName,
      amount: amount,
      zScoreValue: z,
    );
  }
}
