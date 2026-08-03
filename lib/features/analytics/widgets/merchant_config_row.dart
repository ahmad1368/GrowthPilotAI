import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';

/// One merchant's configuration profile row (Issue #338). Tapping opens
/// its dedicated management profile for direct parameter editing.
class MerchantConfigRow extends StatelessWidget {
  final MerchantConfigEntity config;
  final VoidCallback onTap;

  const MerchantConfigRow({super.key, required this.config, required this.onTap});

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
                child: Text('${config.businessName} (${config.businessId})',
                    overflow: TextOverflow.ellipsis)),
            Text('${config.commissionRatePercent.toStringAsFixed(1)}%',
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.primary)),
            const SizedBox(width: 8),
            Icon(Icons.chevron_right, size: 18, color: scheme.onSurface.withValues(alpha: 0.5)),
          ],
        ),
      ),
    );
  }
}
