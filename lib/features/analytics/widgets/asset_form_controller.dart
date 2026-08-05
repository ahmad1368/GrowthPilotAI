import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/asset_listing_entity.dart';

/// Holds the new-listing form's text controllers and derives the
/// submitted entity (Issue #412) — split out of
/// [AssetDialogContent] to stay under the file line cap.
class AssetFormController {
  final sellerName = TextEditingController();
  final assetName = TextEditingController();
  final conditionDescription = TextEditingController();
  final marketValue = TextEditingController();
  final askingPrice = TextEditingController();
  final commercialZone = TextEditingController();
  final pickupDays = TextEditingController(text: '7');

  bool get isValid =>
      sellerName.text.trim().isNotEmpty &&
      assetName.text.trim().isNotEmpty &&
      double.tryParse(marketValue.text) != null &&
      double.tryParse(askingPrice.text) != null;

  AssetListingEntity build() {
    final now = DateTime.now();
    final days = int.tryParse(pickupDays.text)?.clamp(1, 90) ?? 7;
    return AssetListingEntity(
      sellerName: sellerName.text.trim(),
      assetName: assetName.text.trim(),
      conditionDescription: conditionDescription.text.trim(),
      marketValue: double.tryParse(marketValue.text) ?? 0,
      askingPrice: double.tryParse(askingPrice.text) ?? 0,
      commercialZone: commercialZone.text.trim(),
      pickupDeadline: now.add(Duration(days: days)),
      listedAt: now,
    );
  }
}
