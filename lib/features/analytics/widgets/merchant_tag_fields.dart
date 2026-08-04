import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Merchant checklist and tag text input for a bulk-tagging action
/// (Issue #342, acceptance criterion 3).
class MerchantTagFields extends StatelessWidget {
  final List<MerchantTagSummary> merchants;
  final Set<String> selectedBusinessIds;
  final ValueChanged<String> onToggleMerchant;
  final TextEditingController tagLabelController;

  const MerchantTagFields({
    super.key,
    required this.merchants,
    required this.selectedBusinessIds,
    required this.onToggleMerchant,
    required this.tagLabelController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Tag (e.g. East Van, Budget, High-Risk)'),
            controller: tagLabelController),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final m in merchants)
                ShadCheckbox(
                  value: selectedBusinessIds.contains(m.businessId),
                  onChanged: (_) => onToggleMerchant(m.businessId),
                  label: Text('${m.businessName} (${m.businessId})'),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
