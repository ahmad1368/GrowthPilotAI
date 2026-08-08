import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/procurement_response_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/procurement_response_repository.dart';

/// Bundles the repositories the B2B analytics dashboard needs (Issue #129).
class B2bAnalyticsRepos {
  final store = Get.find<ObjectBox>().store;

  late final requests =
      ProcurementRequestRepository(store.box<ProcurementRequestEntity>());
  late final responses =
      ProcurementResponseRepository(store.box<ProcurementResponseEntity>());
}
