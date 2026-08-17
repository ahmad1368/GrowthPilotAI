import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/summarize_usage_events.dart';
import 'package:growth_pilot_ai/core/data/repositories/local_usage_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

/// Drives the "Transparency Report" view of locally-logged usage events
/// (Issue #539).
class LocalUsageAnalyticsController extends GetxController {
  final LocalUsageEventRepository _repository;
  final summary = <UsageEventType, int>{}.obs;

  LocalUsageAnalyticsController(this._repository);

  @override
  void onInit() {
    super.onInit();
    reload();
  }

  void reload() {
    summary.assignAll(SummarizeUsageEvents.call(_repository.getAll()));
  }
}
