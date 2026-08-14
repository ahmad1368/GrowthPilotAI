import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/product_listing_details_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/service_listing_details_repository.dart';

/// Bundles the repositories the Admin Product Table needs (Issue
/// #143).
class AdminTableRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = CatalogListingRepository(store.box<CatalogListingEntity>());
  late final productDetails =
      ProductListingDetailsRepository(store.box<ProductListingDetailsEntity>());
  late final serviceDetails =
      ServiceListingDetailsRepository(store.box<ServiceListingDetailsEntity>());
}
