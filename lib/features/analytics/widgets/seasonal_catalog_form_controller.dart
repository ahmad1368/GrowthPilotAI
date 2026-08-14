import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';

/// Holds the new-catalog-line form's text controllers and derives the
/// submitted entity (Issue #417) — split out of
/// [SeasonalCatalogDialogContent] to stay under the file line cap.
class SeasonalCatalogFormController {
  final supplierName = TextEditingController();
  final productName = TextEditingController();
  final productDescription = TextEditingController();
  final unitPrice = TextEditingController();
  final depositPercent = TextEditingController(text: '20');
  final deliveryWindowDays = TextEditingController(text: '60');

  bool get isValid =>
      supplierName.text.trim().isNotEmpty &&
      productName.text.trim().isNotEmpty &&
      double.tryParse(unitPrice.text) != null &&
      double.tryParse(depositPercent.text) != null;

  SeasonalCatalogItemEntity build() {
    final now = DateTime.now();
    final days = int.tryParse(deliveryWindowDays.text)?.clamp(1, 365) ?? 60;
    final depositFraction = ((double.tryParse(depositPercent.text) ?? 20) / 100).clamp(0.01, 1.0);
    return SeasonalCatalogItemEntity(
      supplierName: supplierName.text.trim(),
      productName: productName.text.trim(),
      productDescription: productDescription.text.trim(),
      unitPrice: double.tryParse(unitPrice.text) ?? 0,
      depositPercent: depositFraction,
      deliveryWindowStart: now.add(Duration(days: days)),
      listedAt: now,
    );
  }
}
