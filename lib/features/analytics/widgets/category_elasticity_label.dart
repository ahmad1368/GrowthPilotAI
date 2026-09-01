import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/category_elasticity.dart';

/// Category name with an elasticity-hint icon (Issue #380): a warning icon
/// for price-sensitive ("elastic") categories, a check for price-insensitive
/// ("inelastic") ones, nothing for insufficient history.
class CategoryElasticityLabel extends StatelessWidget {
  final CategoryElasticity item;

  const CategoryElasticityLabel({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    IconData? icon;
    Color color = scheme.onSurface.withValues(alpha: 0.5);
    switch (item.hint) {
      case ElasticityHint.elastic:
        icon = Icons.warning_amber_rounded;
        color = scheme.error;
        break;
      case ElasticityHint.inelastic:
        icon = Icons.check_circle_outline;
        color = scheme.primary;
        break;
      case ElasticityHint.insufficient:
        icon = null;
        break;
    }

    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Flexible(child: Text(item.categoryName, overflow: TextOverflow.ellipsis)),
      ],
    );
  }
}
