import 'dart:typed_data';

/// Resolves a listing's first linked image thumbnail, if any (Issue
/// #142, "Product Catalog UI") — takes a plain id->bytes lookup
/// instead of a live repository, so it stays unit-testable.
class ResolveListingThumbnail {
  static Uint8List? call(String imageVariantIdsCsv, Map<int, Uint8List> thumbnailsById) {
    final ids = imageVariantIdsCsv.split(',').where((s) => s.isNotEmpty);
    if (ids.isEmpty) return null;
    return thumbnailsById[int.parse(ids.first)];
  }
}
