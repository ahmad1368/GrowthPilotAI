import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/cap_expansion_status.dart';

/// One-sentence read on today's cap status and any pending expansion
/// requests (Issue #344).
class BuildDailyCapNarrative {
  static String call({
    required double dailyTotal,
    required double capAmount,
    required bool isBlocked,
    required List<CapExpansionRequestEntity> requests,
  }) {
    final pending = requests.where((r) => r.status == CapExpansionStatus.pending).length;
    final capLine = isBlocked
        ? 'Blocked: today\'s \$${dailyTotal.toStringAsFixed(2)} exceeds the '
            '\$${capAmount.toStringAsFixed(2)} daily cap.'
        : 'Within cap: \$${dailyTotal.toStringAsFixed(2)} of '
            '\$${capAmount.toStringAsFixed(2)} used today.';
    if (pending == 0) return capLine;
    return '$capLine $pending expansion request(s) awaiting admin review.';
  }
}
