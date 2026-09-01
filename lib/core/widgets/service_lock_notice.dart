import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/service_restriction_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the customized restriction reason when a service is locked
/// (Issue #337) — feature screens gated by a service name should show
/// this in place of their content whenever the matching
/// [ServiceRestrictionStatus] has `isBlocked: true`.
class ServiceLockNotice extends StatelessWidget {
  final ServiceRestrictionStatus status;

  const ServiceLockNotice({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return ShadCard(
      child: Row(
        children: [
          Icon(Icons.lock_outline, color: fg, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(status.reasonMessage.isEmpty
                ? '${status.serviceName} is currently locked for your account.'
                : status.reasonMessage),
          ),
        ],
      ),
    );
  }
}
