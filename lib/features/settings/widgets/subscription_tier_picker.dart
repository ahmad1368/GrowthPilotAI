import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/business/monthly_price_for_tier.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// "Switch from Basic to Pro" tier picker (Issue #171) — the native
/// in-app stand-in for the Stripe Customer Portal's plan switcher.
class SubscriptionTierPicker extends StatelessWidget {
  final SubscriptionTier selected;
  final ValueChanged<SubscriptionTier> onSelected;

  const SubscriptionTierPicker({super.key, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Column(
      children: SubscriptionTier.values.map((tier) {
        final isSelected = tier == selected;
        final price = MonthlyPriceForTier.call(tier);
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          color: isSelected ? colors.primary.withValues(alpha: 0.1) : colors.card,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: isSelected ? colors.primary : colors.border),
          ),
          child: ListTile(
            title: Text(tier.name, style: TextStyle(color: colors.foreground)),
            subtitle: Text(price == 0 ? 'Free' : '\$${price.toStringAsFixed(2)}/mo CAD',
                style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
            trailing: isSelected ? Icon(Icons.check_circle_rounded, color: colors.primary) : null,
            onTap: () => onSelected(tier),
          ),
        );
      }).toList(),
    );
  }
}
