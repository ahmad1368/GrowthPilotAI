import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/brand_penetration_index.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Executive scorecard for the Brand Penetration Index (Issue #359): the
/// user's trailing-30-day revenue against a mocked neighborhood-category
/// benchmark — see [GetRegionalCategoryBenchmark] for why it's mocked.
class BrandPenetrationScorecard extends StatelessWidget {
  final BrandPenetrationIndex index;

  const BrandPenetrationScorecard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final barFraction = (index.indexPercent / 100).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${index.indexPercent.toStringAsFixed(0)}%',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: scheme.primary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(
          'of your neighborhood category average '
          '(${CurrencyFormat.cad(index.neighborhoodBenchmarkVolume)}/mo)',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: barFraction,
            minHeight: 8,
            backgroundColor: scheme.onSurface.withValues(alpha: 0.08),
            color: scheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text('Your revenue: ${CurrencyFormat.cad(index.userVolume)}/mo'),
      ],
    );
  }
}
