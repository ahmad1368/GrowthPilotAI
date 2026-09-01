import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';

/// Renders the sponsored card matching standard tile styling (Issue
/// #402, acceptance criteria 1 and 5) — the surrounding tile's
/// "Sponsored" title already serves as the disclosure label, so the
/// content here reads identically to any other card's body. Purely
/// presentational, telemetry is owned by [PromoCardBody].
class PromoCardView extends StatelessWidget {
  final AdvertisingRequestEntity? selected;
  final double engagementRatePercent;
  final int impressionCount;
  final VoidCallback onTap;

  const PromoCardView({
    super.key,
    required this.selected,
    required this.engagementRatePercent,
    required this.impressionCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (selected == null) {
      return Text('No sponsored content available for this context.',
          style: TextStyle(color: scheme.onSurface.withValues(alpha: 0.6)));
    }
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${selected!.merchantName} — ${selected!.category}',
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text('Featured ${selected!.packageType.name}'),
          const SizedBox(height: 8),
          Text('$impressionCount impression(s) · ${engagementRatePercent.toStringAsFixed(1)}% CTR',
              style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
        ],
      ),
    );
  }
}
