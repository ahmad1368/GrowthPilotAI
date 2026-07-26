import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name/contact/payment-terms/lead-time inputs for a new supplier
/// (Issue #442).
class SupplierFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController contactController;
  final TextEditingController paymentTermsController;
  final TextEditingController leadTimeController;

  const SupplierFields({
    super.key,
    required this.nameController,
    required this.contactController,
    required this.paymentTermsController,
    required this.leadTimeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(placeholder: const Text('Supplier name'), controller: nameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Contact info (phone/email)'), controller: contactController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Payment terms (e.g. Net 30)'),
            controller: paymentTermsController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Typical lead time (days)'),
            controller: leadTimeController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly]),
      ],
    );
  }
}
