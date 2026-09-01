import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Digits-only quantity field shared by the stock-movement and
/// stock-reservation dialogs (Issue #445).
class StockQuantityInput extends StatelessWidget {
  final TextEditingController controller;

  const StockQuantityInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Quantity'),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }
}
