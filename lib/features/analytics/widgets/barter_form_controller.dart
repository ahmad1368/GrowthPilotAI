import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/barter_listing_entity.dart';

/// Holds the new-listing form's text controllers and derives the
/// submitted entity (Issue #413) — split out of
/// [BarterDialogContent] to stay under the file line cap.
class BarterFormController {
  final merchantName = TextEditingController();
  final surplusItemName = TextEditingController();
  final surplusItemDescription = TextEditingController();
  final wantedItemName = TextEditingController();
  final category = TextEditingController();
  final estimatedValue = TextEditingController();
  final geoZone = TextEditingController();

  bool get isValid =>
      merchantName.text.trim().isNotEmpty &&
      surplusItemName.text.trim().isNotEmpty &&
      wantedItemName.text.trim().isNotEmpty &&
      double.tryParse(estimatedValue.text) != null;

  BarterListingEntity build() {
    return BarterListingEntity(
      merchantName: merchantName.text.trim(),
      surplusItemName: surplusItemName.text.trim(),
      surplusItemDescription: surplusItemDescription.text.trim(),
      wantedItemName: wantedItemName.text.trim(),
      category: category.text.trim(),
      estimatedValue: double.tryParse(estimatedValue.text) ?? 0,
      geoZone: geoZone.text.trim(),
      listedAt: DateTime.now(),
    );
  }
}
