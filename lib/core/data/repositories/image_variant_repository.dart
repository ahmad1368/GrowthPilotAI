import '../../../../objectbox.g.dart';
import '../entities/image_variant_entity.dart';

/// Insert/lookup CRUD for processed image variants (Issue #139).
class ImageVariantRepository {
  final Box<ImageVariantEntity> _box;

  ImageVariantRepository(this._box);

  int save(ImageVariantEntity variant) => _box.put(variant);

  List<ImageVariantEntity> getAll() => _box.getAll();
}
