import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_campaign_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The name/channel/cost fields plus start/end date pickers for a new ad
/// campaign (Issue #366).
class AdCampaignFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController costController;
  final AdChannel channel;
  final ValueChanged<AdChannel> onChannelChanged;
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onPickStartDate;
  final VoidCallback onPickEndDate;

  const AdCampaignFields({
    super.key,
    required this.nameController,
    required this.costController,
    required this.channel,
    required this.onChannelChanged,
    required this.startDate,
    required this.endDate,
    required this.onPickStartDate,
    required this.onPickEndDate,
  });

  String _label(DateTime? date, String placeholder) => date == null
      ? placeholder
      : '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Campaign name'), controller: nameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Cost (\$)'),
            controller: costController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadSelect<AdChannel>(
          initialValue: channel,
          options: AdChannel.values
              .map((c) => ShadOption(value: c, child: Text(c.name)))
              .toList(),
          selectedOptionBuilder: (context, value) => Text(value.name),
          onChanged: (value) {
            if (value != null) onChannelChanged(value);
          },
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickStartDate,
          child: Text(_label(startDate, 'Pick start date'), style: TextStyle(color: fg)),
        ),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickEndDate,
          child: Text(_label(endDate, 'Pick end date'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
