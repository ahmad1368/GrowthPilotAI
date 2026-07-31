import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/neighborhood_expansion_potential.dart';
import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// One logged neighborhood's expansion risk/reward row (Issue #372).
class NeighborhoodExpansionRow extends StatelessWidget {
  final NeighborhoodExpansionPotential result;

  const NeighborhoodExpansionRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(result.neighborhoodName,
                  overflow: TextOverflow.ellipsis)),
          Text('${result.riskLevel.name} risk',
              style: TextStyle(
                  fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.6))),
          const SizedBox(width: 12),
          Text(CurrencyFormat.cad(result.netOpportunity),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: result.isViable ? scheme.primary : scheme.error)),
        ],
      ),
    );
  }
}
