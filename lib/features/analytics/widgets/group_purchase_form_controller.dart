import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/group_purchase_entity.dart';

/// Holds the new-campaign form's text controllers and derives the
/// submitted entity (Issue #414) — split out of
/// [GroupPurchaseDialogContent] to stay under the file line cap.
class GroupPurchaseFormController {
  final organizerName = TextEditingController();
  final itemName = TextEditingController();
  final itemDescription = TextEditingController();
  final unitPrice = TextEditingController();
  final minQuantityThreshold = TextEditingController();
  final deadlineDays = TextEditingController(text: '14');

  bool get isValid =>
      organizerName.text.trim().isNotEmpty &&
      itemName.text.trim().isNotEmpty &&
      double.tryParse(unitPrice.text) != null &&
      int.tryParse(minQuantityThreshold.text) != null;

  GroupPurchaseEntity build() {
    final now = DateTime.now();
    final days = int.tryParse(deadlineDays.text)?.clamp(1, 90) ?? 14;
    return GroupPurchaseEntity(
      organizerName: organizerName.text.trim(),
      itemName: itemName.text.trim(),
      itemDescription: itemDescription.text.trim(),
      unitPrice: double.tryParse(unitPrice.text) ?? 0,
      minQuantityThreshold: int.tryParse(minQuantityThreshold.text) ?? 0,
      deadline: now.add(Duration(days: days)),
      createdAt: now,
    );
  }
}
