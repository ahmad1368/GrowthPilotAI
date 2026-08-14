import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/user_location_preference_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/catalog_listing_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/user_location_preference_repository.dart';

/// Bundles the repositories the geo-location demo needs (Issue #213).
class GeoLocationRepos {
  final store = Get.find<ObjectBox>().store;

  late final location = UserLocationPreferenceRepository(store.box<UserLocationPreferenceEntity>());
  late final listings = CatalogListingRepository(store.box<CatalogListingEntity>());
}
