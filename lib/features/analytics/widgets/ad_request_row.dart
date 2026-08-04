import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One advertising request row (Issue #401) — admin approve/deny
/// buttons only show while pending, routing the request to the
/// "central ad management system" review step.
class AdRequestRow extends StatelessWidget {
  final AdvertisingRequestEntity request;
  final ValueChanged<bool> onDecision;

  const AdRequestRow({super.key, required this.request, required this.onDecision});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Text(
                  '${request.merchantName} (${request.category}) — ${request.packageType.name}',
                  overflow: TextOverflow.ellipsis)),
          if (request.status == AdRequestStatus.pending) ...[
            ShadButton.ghost(onPressed: () => onDecision(true), child: const Text('Approve')),
            ShadButton.ghost(onPressed: () => onDecision(false), child: const Text('Deny')),
          ] else
            Text(request.status.name,
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
        ],
      ),
    );
  }
}
