import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/cap_expansion_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One cap expansion request row (Issue #344, acceptance criterion 3).
/// Approve/deny buttons only show while the request is pending — admin
/// review is a one-time decision.
class CapExpansionRequestRow extends StatelessWidget {
  final CapExpansionRequestEntity request;
  final ValueChanged<bool> onDecision;

  const CapExpansionRequestRow({super.key, required this.request, required this.onDecision});

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
                  '\$${request.requestedCapAmount.toStringAsFixed(2)} — ${request.reason}',
                  overflow: TextOverflow.ellipsis)),
          if (request.status == CapExpansionStatus.pending) ...[
            ShadButton.ghost(
                onPressed: () => onDecision(true), child: const Text('Approve')),
            ShadButton.ghost(onPressed: () => onDecision(false), child: const Text('Deny')),
          ] else
            Text(request.status.name,
                style: TextStyle(fontWeight: FontWeight.w600, color: scheme.onSurface)),
        ],
      ),
    );
  }
}
