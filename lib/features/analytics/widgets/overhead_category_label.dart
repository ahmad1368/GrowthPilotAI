import 'package:flutter/material.dart';

/// Category name with an optional over-budget warning icon (Issue #367).
class OverheadCategoryLabel extends StatelessWidget {
  final String categoryName;
  final bool isOverBudget;
  final Color color;

  const OverheadCategoryLabel({
    super.key,
    required this.categoryName,
    required this.isOverBudget,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isOverBudget) ...[
          Icon(Icons.warning_amber_rounded, size: 14, color: color),
          const SizedBox(width: 4),
        ],
        Flexible(
          child: Text(categoryName, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
