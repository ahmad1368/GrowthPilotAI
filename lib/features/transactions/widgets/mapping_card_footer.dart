import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/category_mapping_controller.dart';
import 'package:growth_pilot_ai/core/models/chart_of_account.dart';
import 'package:growth_pilot_ai/core/models/merchant_mapping_group.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Always map..." rule toggle + Confirm button for one [MerchantMappingGroup]
/// (Issue #58). Shows a Retry-style button (no crash) if confirming fails.
class MappingCardFooter extends StatelessWidget {
  final MerchantMappingGroup group;
  final ChartOfAccount? selected;
  final CategoryMappingController controller;

  const MappingCardFooter({
    super.key,
    required this.group,
    required this.selected,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isConfirming = controller.confirmingMerchant.value == group.merchantName;
      final ruleEnabled = controller.createRule[group.merchantName] ?? false;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShadSwitch(
              value: ruleEnabled,
              label: const Text('Always map to this category'),
              onChanged: (v) => controller.toggleCreateRule(group.merchantName, v),
            ),
          ),
          ShadButton(
            enabled: selected != null && !isConfirming,
            leading: isConfirming
                ? const SizedBox(
                    width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                : null,
            onPressed: selected == null
                ? null
                : () => controller.confirm(group, selected!.accountName),
            child: Text(isConfirming ? 'Confirming...' : 'Confirm'),
          ),
        ],
      );
    });
  }
}
