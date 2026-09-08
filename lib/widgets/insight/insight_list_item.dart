import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/core/theme/insight_category_style.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_card_content.dart';
import '../../models/insight_model.dart';

/// [Issue #837] Redesigned into a card with a category-colored accent bar
/// and an actual efficiency ring (previously parsed but never rendered).
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
    final visual = InsightCategoryStyle.forCategory(data.category);
    final percent = (double.tryParse(data.efficiency.replaceAll('%', '')) ?? 0) / 100;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppDesignTokens.card(theme.brightness),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? visual.color : onSurface.withValues(alpha: 0.08),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(width: 4, color: visual.color),
                Expanded(
                  child: InsightCardContent(
                    data: data,
                    visual: visual,
                    percent: percent,
                    descriptionColor: onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
