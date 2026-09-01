import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';

/// Human-readable label for a waste reason (Issue #377).
class FormatWasteReason {
  static String call(WasteReason reason) {
    switch (reason) {
      case WasteReason.expiration:
        return 'Expiration';
      case WasteReason.damage:
        return 'Damage';
      case WasteReason.overPreparation:
        return 'Over-Preparation';
      case WasteReason.other:
        return 'Other';
    }
  }
}
