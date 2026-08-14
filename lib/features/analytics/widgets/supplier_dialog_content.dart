import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showSupplierDialog] (Issue #442): owns the
/// name/contact/payment-terms/lead-time controllers.
class SupplierDialogContent extends StatefulWidget {
  const SupplierDialogContent({super.key});

  @override
  State<SupplierDialogContent> createState() => _SupplierDialogContentState();
}

class _SupplierDialogContentState extends State<SupplierDialogContent> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _paymentTermsController = TextEditingController();
  final _leadTimeController = TextEditingController();

  void _submit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;
    Navigator.of(context).pop(VendorEntity(
      name: name,
      contactInfo: _contactController.text.trim(),
      paymentTerms: _paymentTermsController.text.trim(),
      typicalLeadTimeDays: int.tryParse(_leadTimeController.text.trim()) ?? 0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Add Supplier'),
      description: SupplierFields(
        nameController: _nameController,
        contactController: _contactController,
        paymentTermsController: _paymentTermsController,
        leadTimeController: _leadTimeController,
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
