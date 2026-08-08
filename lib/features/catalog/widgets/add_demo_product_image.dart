import 'package:growth_pilot_ai/business/generate_demo_source_image.dart';
import 'package:growth_pilot_ai/business/generate_image_variants.dart';
import 'package:growth_pilot_ai/core/data/entities/image_variant_entity.dart';
import 'package:growth_pilot_ai/features/catalog/widgets/product_form_repos.dart';

/// Generates and stores a demo photo's optimized variants, standing
/// in for the upload picker (Issue #140, Step 4 "Media Gallery").
int addDemoProductImage(ProductFormRepos repos) {
  final variants = GenerateImageVariants.call(GenerateDemoSourceImage.call());
  return repos.images.save(ImageVariantEntity(
    label: 'Product Photo',
    originalSizeBytes: variants.originalSizeBytes,
    thumbnailBytes: variants.thumbnail,
    thumbnailSizeBytes: variants.thumbnail.length,
    standardBytes: variants.standard,
    standardSizeBytes: variants.standard.length,
    dataReductionPercent: 0,
    createdAt: DateTime.now(),
  ));
}
