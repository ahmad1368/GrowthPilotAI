import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_campaign_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showAdCampaignDialog] (Issue #366): owns the
/// text controllers, selected channel, and picked date range.
class AdCampaignDialogContent extends StatefulWidget {
  const AdCampaignDialogContent({super.key});

  @override
  State<AdCampaignDialogContent> createState() => _AdCampaignDialogContentState();
}

class _AdCampaignDialogContentState extends State<AdCampaignDialogContent> {
  final _nameController = TextEditingController();
  final _costController = TextEditingController();
  AdChannel _channel = AdChannel.digital;
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
    final cost = double.tryParse(_costController.text);
    if (_nameController.text.trim().isEmpty ||
        cost == null ||
        cost < 0 ||
        _startDate == null ||
        _endDate == null ||
        _endDate!.isBefore(_startDate!)) {
      return;
    }
    Navigator.of(context).pop(AdCampaignEntity(
      name: _nameController.text.trim(),
      cost: cost,
      startDate: _startDate!,
      endDate: _endDate!,
    )..channel = _channel);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Ad Campaign'),
      description: AdCampaignFields(
        nameController: _nameController,
        costController: _costController,
        channel: _channel,
        onChannelChanged: (c) => setState(() => _channel = c),
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
