import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';
import 'package:growth_pilot_ai/core/enum/anomaly_type.dart';
import 'package:growth_pilot_ai/core/enum/recommendation_type.dart';

/// Display-ready shape of one ACTION_CARD message's payload (Issue #73),
/// parsed from a [MessageEntity] by [ParseActionCardData]. [merchantName]
/// and [anomalyType] are only set for [ActionCardType.reviewAnomaly] cards
/// (Issue #74); [recommendationType]/[actionLabel] only for
/// [ActionCardType.smartRecommendation] cards (Issue #75).
@immutable
class ActionCardData {
  final int messageId;
  final ActionCardType actionType;
  final ActionCardStatus status;
  final double amount;
  final String? transactionRefId;
  final String? merchantName;
  final AnomalyType? anomalyType;
  final RecommendationType? recommendationType;
  final String? actionLabel;

  const ActionCardData({
    required this.messageId,
    required this.actionType,
    required this.status,
    required this.amount,
    this.transactionRefId,
    this.merchantName,
    this.anomalyType,
    this.recommendationType,
    this.actionLabel,
  });

  bool get isPending => status == ActionCardStatus.pending;
}
