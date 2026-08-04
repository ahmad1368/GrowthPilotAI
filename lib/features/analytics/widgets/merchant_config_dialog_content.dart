import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_config_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showMerchantConfigDialog] (Issue #338): when
/// [existing] is provided the fields are pre-filled and its `id` is
/// preserved so saving updates the same profile in place.
class MerchantConfigDialogContent extends StatefulWidget {
  final MerchantConfigEntity? existing;

  const MerchantConfigDialogContent({super.key, this.existing});

  @override
  State<MerchantConfigDialogContent> createState() =>
      _MerchantConfigDialogContentState();
}

class _MerchantConfigDialogContentState
    extends State<MerchantConfigDialogContent> {
  late final _businessNameController =
      TextEditingController(text: widget.existing?.businessName);
  late final _businessIdController =
      TextEditingController(text: widget.existing?.businessId);
  late final _commissionRateController = TextEditingController(
      text: widget.existing?.commissionRatePercent.toString());
  late final _commissionFixedAmountController = TextEditingController(
      text: widget.existing?.commissionFixedAmount.toString());
  late final _transactionCapController = TextEditingController(
      text: widget.existing?.transactionCapAmount.toString());
  late final _notesController =
      TextEditingController(text: widget.existing?.notes);
  late CommissionType _commissionType =
      widget.existing?.commissionType ?? CommissionType.percentage;

  void _submit() {
    final commissionRate = double.tryParse(_commissionRateController.text) ?? 0;
    final commissionFixedAmount =
        double.tryParse(_commissionFixedAmountController.text) ?? 0;
    final transactionCap = double.tryParse(_transactionCapController.text);
    if (_businessNameController.text.trim().isEmpty ||
        _businessIdController.text.trim().isEmpty ||
        commissionRate < 0 ||
        commissionFixedAmount < 0 ||
        transactionCap == null ||
        transactionCap < 0) {
      return;
    }
    Navigator.of(context).pop(MerchantConfigEntity(
      id: widget.existing?.id ?? 0,
      businessName: _businessNameController.text.trim(),
      businessId: _businessIdController.text.trim(),
      commissionRatePercent: commissionRate,
      commissionFixedAmount: commissionFixedAmount,
      dbCommissionType: _commissionType.index,
      transactionCapAmount: transactionCap,
      notes: _notesController.text.trim(),
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: Text(widget.existing == null
          ? 'Add Merchant Profile'
          : 'Edit Merchant Profile'),
      description: MerchantConfigFields(
        businessNameController: _businessNameController,
        businessIdController: _businessIdController,
        commissionType: _commissionType,
        onCommissionTypeChanged: (t) => setState(() => _commissionType = t),
        commissionRateController: _commissionRateController,
        commissionFixedAmountController: _commissionFixedAmountController,
        transactionCapController: _transactionCapController,
        notesController: _notesController,
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
