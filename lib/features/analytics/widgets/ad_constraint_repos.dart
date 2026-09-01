import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_constraint_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/promo_card_metrics_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/ad_campaign_constraint_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/advertising_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/promo_card_metrics_repository.dart';

/// Bundles the repositories the constraint dashboard needs (Issue
/// #409) — split out of [AdConstraintActions] to stay under the file
/// line cap.
class AdConstraintRepos {
  final store = Get.find<ObjectBox>().store;

  late final constraints =
      AdCampaignConstraintRepository(store.box<AdCampaignConstraintEntity>());
  late final metrics = PromoCardMetricsRepository(store.box<PromoCardMetricsEntity>());
  late final requests = AdvertisingRequestRepository(store.box<AdvertisingRequestEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
