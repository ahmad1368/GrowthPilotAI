import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/wholesale_order_repository.dart';

/// Bundles the repositories the wholesale marketplace needs (Issue
/// #411) — [store] is also passed straight to [ApplyStockMovement]
/// (#439), which owns its own item/movement box access.
class WholesaleRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = WholesaleListingRepository(store.box<WholesaleListingEntity>());
  late final orders = WholesaleOrderRepository(store.box<WholesaleOrderEntity>());
}
