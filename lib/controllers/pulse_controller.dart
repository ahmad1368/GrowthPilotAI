import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/pulse_analytics_processor.dart';
import 'package:growth_pilot_ai/core/data/entities/pulse_event_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/pulse_event_repository.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart';
import 'package:growth_pilot_ai/core/models/pulse_gratification_result.dart';

/// Drives OmniPulse's crowdsourced business radar (Issue #267/#268) —
/// the local feed of reports plus the instant-gratification feedback
/// loop via [PulseAnalyticsProcessor].
class PulseController extends GetxController {
  static const reporterId = 'local-user';

  late PulseEventRepository _events;
  final feed = <PulseEventEntity>[].obs;
  final Rxn<PulseGratificationResult> lastGratification = Rxn<PulseGratificationResult>();

  @override
  void onInit() {
    super.onInit();
    _events = PulseEventRepository(Get.find<ObjectBox>().store.box());
    _refresh();
  }

  void _refresh() => feed.assignAll(_events.getAll());

  void submitReport({
    required PulseCategory category,
    required String title,
    required String description,
    required String region,
    required double estimatedImpactCad,
  }) {
    _events.append(PulseEventEntity(
      reporterId: reporterId,
      dbCategory: category.index,
      title: title,
      description: description,
      region: region,
      estimatedImpactCad: estimatedImpactCad,
      reportedAt: DateTime.now(),
    ));
    lastGratification.value =
        PulseAnalyticsProcessor.call(category: category, estimatedImpactCad: estimatedImpactCad, helpfulCount: 0);
    _refresh();
  }

  void markHelpful(PulseEventEntity event) {
    _events.markHelpful(event);
    _refresh();
  }
}
