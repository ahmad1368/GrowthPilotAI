import 'package:flutter/material.dart';

/// [Issue #837] Category label + title + description column; split out
/// of InsightListItem to stay under this repo's per-file line cap.
class InsightTextColumn extends StatelessWidget {
  final String category;
  final String title;
  final String description;
  final Color categoryColor;
  final Color descriptionColor;

  const InsightTextColumn({
    super.key,
    required this.category,
    required this.title,
    required this.description,
    required this.categoryColor,
    required this.descriptionColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(category,
            style: theme.textTheme.labelSmall
                ?.copyWith(color: categoryColor, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(title, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 6),
        Text(description, style: theme.textTheme.bodyMedium?.copyWith(color: descriptionColor)),
      ],
    );
  }
}
