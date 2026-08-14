import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_ad_request_narrative.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a submit button, per-request rows, and a summary narrative
/// (Issue #401). Purely presentational — the request list is owned by
/// [AdRequestBody].
class AdRequestView extends StatelessWidget {
  final List<AdvertisingRequestEntity> requests;
  final VoidCallback onSubmitRequest;
  final void Function(AdvertisingRequestEntity, bool) onDecision;

  const AdRequestView({
    super.key,
    required this.requests,
    required this.onSubmitRequest,
    required this.onDecision,
  });

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
              onPressed: onSubmitRequest,
              child: Text('+ Request Ad Package', style: TextStyle(color: fg)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        for (final request in requests)
          AdRequestRow(request: request, onDecision: (a) => onDecision(request, a)),
        const SizedBox(height: 8),
        Text(BuildAdRequestNarrative.call(requests)),
      ],
    );
  }
}
