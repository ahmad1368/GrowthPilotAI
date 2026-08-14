import 'package:flutter/material.dart';

/// Contract every pluggable report widget must follow (Issue #111), so the
/// [ReportWidgetRegistry] can render any of them identically without the
/// view knowing what's actually inside. Flat card per the current design
/// system, not the original issue's Glassmorphism ask.
abstract class BaseReportWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String title;

  const BaseReportWidget({
    super.key,
    required this.data,
    required this.title,
  });

  /// Subclasses render only their inner content here; the surrounding card
  /// and title are standardized by [build].
  Widget buildContent(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.colorScheme.onSurface;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: fg.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleSmall),
          const SizedBox(height: 12),
          buildContent(context),
        ],
      ),
    );
  }
}
