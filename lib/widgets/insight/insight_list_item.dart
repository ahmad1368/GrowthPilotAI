import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import '../../models/insight_model.dart';

/// Flat insight item — replaces the former OmniGlassPanel title/description
/// card with a plain flat container (matches AppDrawer/NotificationSheet's
/// pattern).
class InsightListItem extends StatelessWidget {
  final InsightModel data;
  final bool isSelected;
  final VoidCallback onTap;

  const InsightListItem({
    super.key,
    required this.data,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppDesignTokens.card(theme.brightness),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? Colors.blueAccent
                  : onSurface.withValues(alpha: 0.08),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.auto_graph_rounded,
                  color: onSurface.withValues(alpha: 0.9), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.title,
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(data.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                            color: onSurface.withValues(alpha: 0.7))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
