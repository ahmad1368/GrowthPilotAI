import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/models/purchase_order_draft.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Review/edit form for an auto-generated purchase-order draft (Issue
/// #443): the user can adjust the vendor name and item summary before
/// saving.
class PurchaseOrderDialogContent extends StatefulWidget {
  final PurchaseOrderDraft draft;

  const PurchaseOrderDialogContent({super.key, required this.draft});

  @override
  State<PurchaseOrderDialogContent> createState() => _PurchaseOrderDialogContentState();
}

class _PurchaseOrderDialogContentState extends State<PurchaseOrderDialogContent> {
  late final _vendorController = TextEditingController();
  late final _summaryController = TextEditingController(text: widget.draft.itemsSummary);

  void _submit() {
    final summary = _summaryController.text.trim();
    if (summary.isEmpty) return;
    Navigator.of(context).pop(PurchaseOrderEntity(
      vendorName: _vendorController.text.trim(),
      itemsSummary: summary,
      estimatedTotal: widget.draft.estimatedTotal,
      createdAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Review Purchase Order'),
      description: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInput(
              placeholder: const Text('Supplier (optional)'), controller: _vendorController),
          const SizedBox(height: 8),
          ShadInput(
              placeholder: const Text('Items'), controller: _summaryController, maxLines: 3),
          const SizedBox(height: 8),
          Text('Estimated total: \$${widget.draft.estimatedTotal.toStringAsFixed(2)}'),
        ],
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
