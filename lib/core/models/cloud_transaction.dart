import 'package:flutter/foundation.dart';

/// Server-side representation of a transaction (the cloud counterpart of
/// [TransactionEntity]) used during conflict resolution. [localId] maps back to
/// the device's ObjectBox id; [userId] is the owner and is never reassigned.
@immutable
class CloudTransaction {
  final String localId;
  final String userId;
  final double amount;
  final String? vendor;
  final DateTime lastModified;
  final bool isDeleted;

  const CloudTransaction({
    required this.localId,
    required this.userId,
    required this.amount,
    required this.lastModified,
    this.vendor,
    this.isDeleted = false,
  });
}
