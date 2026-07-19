import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';

/// One flagged transaction (Issue #74): output of
/// [DetectTransactionAnomaly], consumed by [BuildAnomalyNotification] and
/// [BuildAnomalyActionCardMessage].
@immutable
class TransactionAnomaly {
  final AnomalyType type;
  final String transactionRefId;
  final String merchantName;
  final double amount;
  final double? zScoreValue;

  const TransactionAnomaly({
    required this.type,
    required this.transactionRefId,
    required this.merchantName,
    required this.amount,
    this.zScoreValue,
  });
}
