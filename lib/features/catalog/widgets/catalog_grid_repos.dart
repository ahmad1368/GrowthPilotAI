import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/image_variant_repository.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/catalog_repos.dart';

/// Bundles the repositories the Product Catalog grid needs (Issue
/// #142) — reuses [CatalogRepos] for listings/pricing plus an image
/// repo for thumbnails.
class CatalogGridRepos {
  final catalog = CatalogRepos();
  final images = ImageVariantRepository(Get.find<ObjectBox>().store.box<ImageVariantEntity>());
}
