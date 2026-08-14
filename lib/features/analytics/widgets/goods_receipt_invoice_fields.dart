import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Vendor-invoice reference/amount fields for a new goods receipt (Issue
/// #444), matched against the linked purchase order's estimated total.
class GoodsReceiptInvoiceFields extends StatelessWidget {
  final TextEditingController invoiceReferenceController;
  final TextEditingController invoiceAmountController;

  const GoodsReceiptInvoiceFields({
    super.key,
    required this.invoiceReferenceController,
    required this.invoiceAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Invoice reference'),
            controller: invoiceReferenceController),
        const SizedBox(height: 8),
        ShadInput(
          placeholder: const Text('Invoice amount'),
          controller: invoiceAmountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$'))],
        ),
      ],
    );
  }
}
