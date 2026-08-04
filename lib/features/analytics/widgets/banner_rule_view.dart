import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_banner_rule_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banner_rule_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-rule rows, an add button, and a summary narrative
/// (Issue #403, acceptance criterion 4). Purely presentational — the
/// rule list is owned by [BannerRuleBody].
class BannerRuleView extends StatelessWidget {
  final List<BannerMatchingRuleEntity> rules;
  final VoidCallback onAddRule;
  final ValueChanged<BannerMatchingRuleEntity> onEditRule;

  const BannerRuleView({
    super.key,
    required this.rules,
    required this.onAddRule,
    required this.onEditRule,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddRule,
              child: Text('+ Add Rule', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final rule in rules)
          BannerRuleRow(rule: rule, onTap: () => onEditRule(rule)),
        const SizedBox(height: 8),
        Text(BuildBannerRuleNarrative.call(rules)),
      ],
    );
  }
}
