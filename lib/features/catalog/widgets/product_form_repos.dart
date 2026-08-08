import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_form_draft_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/product_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/service_listing_details_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/image_variant_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/product_form_draft_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/product_listing_details_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/service_listing_details_repository.dart';

/// Bundles the repositories the Add/Edit Product form needs (Issue
/// #140).
class ProductFormRepos {
  final store = Get.find<ObjectBox>().store;

  late final listings = CatalogListingRepository(store.box<CatalogListingEntity>());
  late final productDetails =
      ProductListingDetailsRepository(store.box<ProductListingDetailsEntity>());
  late final serviceDetails =
      ServiceListingDetailsRepository(store.box<ServiceListingDetailsEntity>());
  late final images = ImageVariantRepository(store.box<ImageVariantEntity>());
  late final draft = ProductFormDraftRepository(store.box<ProductFormDraftEntity>());
}
