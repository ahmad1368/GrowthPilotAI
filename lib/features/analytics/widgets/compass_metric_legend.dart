import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

const _explanations = [
  'How well your available funds cover short-term obligations.',
  'How fast your spending is growing relative to prior activity.',
  'How spread out your spending is across vendors, vs. concentrated in a few.',
  'How promptly your transactions get reconciled/synced.',
  'The share of income left after expenses.',
];

/// Tappable legend rows under the [BusinessRadarChart] (Issue #84):
/// each opens a "Strategy Insight" dialog explaining that axis, with a
/// disclaimer and a shortcut to the Inbox to discuss it.
class CompassMetricLegend extends StatelessWidget {
  final BusinessCompassMetrics userMetrics;

  const CompassMetricLegend({super.key, required this.userMetrics});

  @override
  Widget build(BuildContext context) {
    final values = userMetrics.toList();
    return Column(
      children: [
        for (var i = 0; i < BusinessCompassMetrics.labels.length; i++)
          ListTile(
            dense: true,
            title: Text(BusinessCompassMetrics.labels[i]),
            trailing: Text('${(values[i] * 100).toStringAsFixed(0)}%'),
            onTap: () => _showInsight(
                context, BusinessCompassMetrics.labels[i], _explanations[i]),
          ),
      ],
    );
  }

  void _showInsight(BuildContext context, String label, String explanation) {
    showShadDialog<void>(
      context: context,
      builder: (context) => ShadDialog.alert(
        title: Text(label),
        description: Text(
            '$explanation\n\nPast performance of sector leaders does not '
            'guarantee future results — this is data analysis, not '
            'certified financial advice.'),
        actions: [
          ShadButton.outline(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
          ShadButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.toNamed('/inbox');
            },
            child: const Text('Discuss in Inbox'),
          ),
        ],
      ),
    );
  }
}
