import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/open_escrow_account.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';

/// Holds the new-escrow form's text controllers and derives the
/// submitted entity (Issue #415) — split out of
/// [EscrowDialogContent] to stay under the file line cap.
class EscrowFormController {
  final buyerName = TextEditingController();
  final sellerName = TextEditingController();
  final itemDescription = TextEditingController();
  final amount = TextEditingController();

  bool get isValid =>
      buyerName.text.trim().isNotEmpty &&
      sellerName.text.trim().isNotEmpty &&
      itemDescription.text.trim().isNotEmpty &&
      double.tryParse(amount.text) != null;

  EscrowAccountEntity build() {
    return OpenEscrowAccount.call(
      buyerName: buyerName.text.trim(),
      sellerName: sellerName.text.trim(),
      itemDescription: itemDescription.text.trim(),
      amount: double.tryParse(amount.text) ?? 0,
      now: DateTime.now(),
    );
  }
}
