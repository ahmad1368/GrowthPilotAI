import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_service_restriction_narrative.dart';
import 'package:growth_pilot_ai/core/models/service_restriction_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/service_restriction_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders per-pair lockdown status rows, a quick-add button, and a
/// summary narrative (Issue #337). Purely presentational — the
/// restriction list is owned by [ServiceRestrictionBody].
class ServiceRestrictionView extends StatelessWidget {
  final List<ServiceRestrictionStatus> results;
  final VoidCallback onAddRestriction;

  const ServiceRestrictionView(
      {super.key, required this.results, required this.onAddRestriction});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: onAddRestriction,
              child: Text('+ Log Restriction', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final result in results) ServiceRestrictionRow(result: result),
        const SizedBox(height: 8),
        Text(BuildServiceRestrictionNarrative.call(results)),
      ],
    );
  }
}
