import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_daily_cap_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cap_expansion_request_row.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/daily_cap_config_field.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the cap config field, a request-increase button, pending
/// requests, and a summary narrative (Issue #344). Purely
/// presentational — state is owned by [DailyCapBody].
class DailyCapView extends StatelessWidget {
  final double capAmount;
  final double dailyTotal;
  final bool isBlocked;
  final List<CapExpansionRequestEntity> requests;
  final ValueChanged<double> onCapSaved;
  final VoidCallback onRequestIncrease;
  final void Function(CapExpansionRequestEntity, bool) onDecision;

  const DailyCapView({
    super.key,
    required this.capAmount,
    required this.dailyTotal,
    required this.isBlocked,
    required this.requests,
    required this.onCapSaved,
    required this.onRequestIncrease,
    required this.onDecision,
  });

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DailyCapConfigField(capAmount: capAmount, onSaved: onCapSaved),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onRequestIncrease,
          child: Text('+ Request Increase', style: TextStyle(color: fg)),
        ),
        const SizedBox(height: 8),
        for (final r in requests)
          CapExpansionRequestRow(request: r, onDecision: (a) => onDecision(r, a)),
        const SizedBox(height: 8),
        Text(BuildDailyCapNarrative.call(
            dailyTotal: dailyTotal, capAmount: capAmount, isBlocked: isBlocked, requests: requests)),
      ],
    );
  }
}
