import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/recommendation_feedback_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/recommendation_feedback_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_order_repository.dart';

/// Bundles the repositories the inventory recommendation engine needs
/// (Issue #418) — reuses [WholesaleListingRepository] and
/// [WholesaleOrderRepository] (#411) as the requisition marketplace,
/// mirroring [WholesaleRepos].
class InventoryRecommendationRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = WholesaleListingRepository(store.box<WholesaleListingEntity>());
  late final orders = WholesaleOrderRepository(store.box<WholesaleOrderEntity>());
  late final feedback = RecommendationFeedbackRepository(store.box<RecommendationFeedbackEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
