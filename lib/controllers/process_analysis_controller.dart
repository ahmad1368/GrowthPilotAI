import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_bottleneck_insights.dart';
import 'package:growth_pilot_ai/business/build_top_bottlenecks_summary.dart';
import 'package:growth_pilot_ai/business/compute_process_complexity_score.dart';
import 'package:growth_pilot_ai/business/find_critical_path.dart';
import 'package:growth_pilot_ai/core/models/bottleneck_insight.dart';
import 'package:growth_pilot_ai/core/models/process_graph.dart';

/// Drives the native "Health Check" panel (Issue #223, section 3) — runs
/// every analysis rule locally and synchronously; there is no Node.js/
/// Python background analysis task to react to (see PR notes), so this
/// updates reactively (GetX `.obs`, this app's own state-management
/// convention) the moment [analyze] is called, rather than via the
/// issue's `ValueNotifier` waiting on a server callback.
class ProcessAnalysisController extends GetxController {
  final topBottlenecks = <BottleneckInsight>[].obs;
  final criticalPath = <String>[].obs;
  final complexityScore = 0.0.obs;

  void analyze(ProcessGraph graph) {
    final insights = BuildBottleneckInsights.call(graph);
    topBottlenecks.assignAll(BuildTopBottlenecksSummary.call(insights));
    criticalPath.assignAll(FindCriticalPath.call(graph));
    complexityScore.value = ComputeProcessComplexityScore.call(graph);
  }
}
