import 'package:flutter/material.dart';

/// Holds text controllers and validates/clears the counter-offer form
/// (Issue #413, acceptance criterion 2) — split out of
/// [BarterProposalInput] to stay under the file line cap.
class BarterProposalFormController {
  final name = TextEditingController();
  final item = TextEditingController();
  final category = TextEditingController();
  final value = TextEditingController();
  final zone = TextEditingController();

  void submit(
      void Function(String proposerName, String itemName, String itemDescription,
              String category, double value, String zone)
          onSubmit) {
    final parsedValue = double.tryParse(value.text);
    if (name.text.trim().isEmpty || item.text.trim().isEmpty || parsedValue == null) return;
    onSubmit(name.text.trim(), item.text.trim(), '', category.text.trim(), parsedValue,
        zone.text.trim());
    name.clear();
    item.clear();
    category.clear();
    value.clear();
    zone.clear();
  }
}
