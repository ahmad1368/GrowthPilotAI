import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/summarize_feature_popularity.dart';
import 'package:growth_pilot_ai/business/summarize_funnel_events.dart';
import 'package:growth_pilot_ai/core/analytics/funnel_event_names.dart';
import 'package:growth_pilot_ai/core/data/repositories/local_usage_event_repository.dart';

/// Drives the local "Revenue & Retention" analytics dashboard (Issue
/// #194) — reads the existing #539 local usage-event log instead of a
/// Firebase Analytics/GA4 dashboard (no such account exists in this
/// repo; see PR notes).
class AnalyticsDashboardController extends GetxController {
  final funnel = <({String label, int count})>[].obs;
  final featurePopularity = <({String label, int count})>[].obs;

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  void reload() {
    final events = GetIt.I<LocalUsageEventRepository>().getAll();
    funnel.assignAll(SummarizeFunnelEvents.call(events, FunnelEventNames.funnelOrder));
    featurePopularity.assignAll(SummarizeFeaturePopularity.call(events));
  }
}
