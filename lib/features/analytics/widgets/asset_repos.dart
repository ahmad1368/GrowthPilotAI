import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_bid_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/asset_bid_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/asset_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';

/// Bundles the repositories the asset liquidation marketplace needs
/// (Issue #412) — split out of the actions classes.
class AssetRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = AssetListingRepository(store.box<AssetListingEntity>());
  late final bids = AssetBidRepository(store.box<AssetBidEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
