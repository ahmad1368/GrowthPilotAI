import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/discount_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/discount_campaign_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showDiscountCampaignDialog] (Issue #362): owns
/// the text controllers and picked date range.
class DiscountCampaignDialogContent extends StatefulWidget {
  const DiscountCampaignDialogContent({super.key});

  @override
  State<DiscountCampaignDialogContent> createState() =>
      _DiscountCampaignDialogContentState();
}

class _DiscountCampaignDialogContentState
    extends State<DiscountCampaignDialogContent> {
  final _nameController = TextEditingController();
  final _discountPercentController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<DateTime?> _pick(DateTime initial) => showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime.now().subtract(const Duration(days: 3650)),
        lastDate: DateTime.now().add(const Duration(days: 3650)),
      );

  Future<void> _pickStartDate() async {
    final picked = await _pick(_startDate ?? DateTime.now());
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _pickEndDate() async {
    final picked = await _pick(_endDate ?? DateTime.now());
    if (picked != null) setState(() => _endDate = picked);
  }

  void _submit() {
    final discountPercent = double.tryParse(_discountPercentController.text);
    if (_nameController.text.trim().isEmpty ||
        discountPercent == null ||
        discountPercent < 0 ||
        discountPercent > 100 ||
        _startDate == null ||
        _endDate == null ||
        _endDate!.isBefore(_startDate!)) {
      return;
    }
    Navigator.of(context).pop(DiscountCampaignEntity(
      name: _nameController.text.trim(),
      discountPercent: discountPercent,
      startDate: _startDate!,
      endDate: _endDate!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Discount Campaign'),
      description: DiscountCampaignFields(
        nameController: _nameController,
        discountPercentController: _discountPercentController,
        startDate: _startDate,
        endDate: _endDate,
        onPickStartDate: _pickStartDate,
        onPickEndDate: _pickEndDate,
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
