import 'package:growth_pilot_ai/core/models/branch_performance_summary.dart';

/// One-sentence read naming the top-performing branch and flagging any
/// branch that needs inventory attention (Issue #400).
class BuildMultiMerchantNarrative {
  static String call(List<BranchPerformanceSummary> results) {
    if (results.isEmpty) {
      return 'No branches logged yet — add one to start supervising performance.';
    }
    final top = results.first;
    final critical = results.where((r) => r.needsAttention).toList();
    final topLine = '${top.branchName} leads with '
        '${top.salesSharePercent.toStringAsFixed(1)}% of enterprise sales.';
    if (critical.isEmpty) return topLine;
    final names = critical.map((r) => r.branchName).join(', ');
    return '$topLine $names ${critical.length == 1 ? 'needs' : 'need'} inventory attention.';
  }
}
