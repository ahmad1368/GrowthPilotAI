import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/image_variant_repository.dart';

/// Bundles the repository the image optimization demo needs (Issue
/// #139).
class MediaRepos {
  final store = Get.find<ObjectBox>().store;

  late final variants = ImageVariantRepository(store.box<ImageVariantEntity>());
}
