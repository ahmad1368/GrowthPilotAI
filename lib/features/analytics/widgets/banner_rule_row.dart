import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banner_matching_rule_entity.dart';

/// One banner matching rule row (Issue #403). Tapping opens its edit
/// dialog for direct category/priority editing.
class BannerRuleRow extends StatelessWidget {
  final BannerMatchingRuleEntity rule;
  final VoidCallback onTap;

  const BannerRuleRow({super.key, required this.rule, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text('${rule.reportTopic} → ${rule.category}',
                    overflow: TextOverflow.ellipsis)),
            Text('weight ${rule.priorityWeight}',
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
          ],
        ),
      ),
    );
  }
}
