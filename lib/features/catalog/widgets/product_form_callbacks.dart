import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/catalog_listing_entity.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';

/// Bundles [ProductFormView]'s event callbacks (Issue #140) so the
/// widget's constructor doesn't need a dozen individual parameters.
typedef ProductFormCallbacks = ({
  void Function(int) onStepChanged,
  void Function(CatalogListingType) onTypeChanged,
  VoidCallback onAddImage,
  void Function(int) onRemoveImage,
  VoidCallback onCleanupStaleImages,
  void Function(CatalogListingEntity) onEditListing,
  VoidCallback onSubmit,
});
