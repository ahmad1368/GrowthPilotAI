import 'package:growth_pilot_ai/business/compute_data_reduction_percent.dart';
import 'package:growth_pilot_ai/business/generate_demo_source_image.dart';
import 'package:growth_pilot_ai/business/generate_image_variants.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_repos.dart';

/// Orchestrates generating + persisting an image's optimized variants
/// (Issue #139).
class MediaActions {
  final MediaRepos repos;
  MediaActions(this.repos);

  List<ImageVariantEntity> get all => repos.variants.getAll();

  void processDemoImage() {
    final source = GenerateDemoSourceImage.call();
    final variants = GenerateImageVariants.call(source);
    final reduction =
        ComputeDataReductionPercent.call(variants.originalSizeBytes, variants.standard.length);
    repos.variants.save(ImageVariantEntity(
      label: 'Demo Product Photo #${all.length + 1}',
      originalSizeBytes: variants.originalSizeBytes,
      thumbnailBytes: variants.thumbnail,
      thumbnailSizeBytes: variants.thumbnail.length,
      standardBytes: variants.standard,
      standardSizeBytes: variants.standard.length,
      dataReductionPercent: reduction,
      createdAt: DateTime.now(),
    ));
  }
}
