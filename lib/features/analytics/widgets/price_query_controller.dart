import 'package:flutter/material.dart';

/// Holds the SKU/candidate-price query form's text controllers
/// (Issue #416) — split out of [PriceIntelligenceBody] to stay under
/// the file line cap.
class PriceQueryController {
  final productName = TextEditingController();
  final candidatePrice = TextEditingController();

  bool get isValid =>
      productName.text.trim().isNotEmpty && double.tryParse(candidatePrice.text) != null;
}
