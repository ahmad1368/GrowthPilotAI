import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/pre_order_reservation_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/seasonal_catalog_item_repository.dart';

/// Bundles the repositories the seasonal pre-ordering engine needs
/// (Issue #417) — split out of the actions classes.
class PreOrderRepos {
  final store = Get.find<ObjectBox>().store;

  late final catalog = SeasonalCatalogItemRepository(store.box<SeasonalCatalogItemEntity>());
  late final reservations =
      PreOrderReservationRepository(store.box<PreOrderReservationEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
