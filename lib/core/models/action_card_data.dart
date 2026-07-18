import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/action_card_status.dart';
import 'package:growth_pilot_ai/core/enum/action_card_type.dart';

/// Display-ready shape of one ACTION_CARD message's payload (Issue #73),
/// parsed from a [MessageEntity] by [ParseActionCardData].
@immutable
class ActionCardData {
  final int messageId;
  final ActionCardType actionType;
  final ActionCardStatus status;
  final double amount;
  final String? transactionRefId;

  const ActionCardData({
    required this.messageId,
    required this.actionType,
    required this.status,
    required this.amount,
    this.transactionRefId,
  });

  bool get isPending => status == ActionCardStatus.pending;
}
