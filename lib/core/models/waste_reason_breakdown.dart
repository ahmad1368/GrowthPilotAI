import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';

/// Total loss + entry count for one waste reason (Issue #377).
@immutable
class WasteReasonBreakdown {
  final WasteReason reason;
  final double totalValue;
  final int entryCount;

  const WasteReasonBreakdown({
    required this.reason,
    required this.totalValue,
    required this.entryCount,
  });
}
