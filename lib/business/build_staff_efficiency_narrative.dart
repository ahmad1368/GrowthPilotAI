import 'package:growth_pilot_ai/core/models/staff_efficiency.dart';

/// One-sentence read naming the fastest and slowest logged staff shifts
/// by transactions handled per hour (Issue #379).
class BuildStaffEfficiencyNarrative {
  static String call(List<StaffEfficiency> results) {
    if (results.isEmpty) {
      return 'No staff shifts logged yet — add one to start tracking efficiency.';
    }
    if (results.length == 1) {
      final only = results.first;
      return '${only.staffName} handled ${only.transactionCount} transactions this shift.';
    }
    final best = results.first;
    final worst = results.last;
    return '${best.staffName} is your fastest performer — '
        '${worst.staffName} trails behind.';
  }
}
