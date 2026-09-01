import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_bulk_tag_assignments.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_tag_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showMerchantTagDialog] (Issue #342): owns the
/// selected merchants and tag text for a bulk-tagging action.
class MerchantTagDialogContent extends StatefulWidget {
  final List<MerchantTagSummary> merchants;

  const MerchantTagDialogContent({super.key, required this.merchants});

  @override
  State<MerchantTagDialogContent> createState() => _MerchantTagDialogContentState();
}

class _MerchantTagDialogContentState extends State<MerchantTagDialogContent> {
  final _tagLabelController = TextEditingController();
  final _selectedBusinessIds = <String>{};

  void _submit() {
    if (_tagLabelController.text.trim().isEmpty || _selectedBusinessIds.isEmpty) return;
    Navigator.of(context).pop(BuildBulkTagAssignments.call(
        _selectedBusinessIds.toList(), _tagLabelController.text.trim(), DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Bulk-Tag Merchants'),
      description: StatefulBuilder(builder: (context, setLocalState) {
        return MerchantTagFields(
          merchants: widget.merchants,
          selectedBusinessIds: _selectedBusinessIds,
          tagLabelController: _tagLabelController,
          onToggleMerchant: (id) => setLocalState(() =>
              _selectedBusinessIds.contains(id)
                  ? _selectedBusinessIds.remove(id)
                  : _selectedBusinessIds.add(id)),
        );
      }),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Apply Tag')),
      ],
    );
  }
}
