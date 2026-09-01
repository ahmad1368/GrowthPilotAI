import 'package:flutter/material.dart';

/// Holds the checkout financing form's text controllers and term
/// selection (Issue #419, acceptance criterion 2) — split out of
/// [MicroCreditDialogContent] to stay under the file line cap.
class MicroCreditFormController {
  final sellerName = TextEditingController();
  final itemDescription = TextEditingController();
  final principal = TextEditingController();
  final termDays = ValueNotifier<int>(30);

  bool get isValid =>
      sellerName.text.trim().isNotEmpty &&
      itemDescription.text.trim().isNotEmpty &&
      double.tryParse(principal.text) != null;
}
