import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/service_restriction_status.dart';

/// One merchant/service pair's current lockdown status row (Issue #337).
class ServiceRestrictionRow extends StatelessWidget {
  final ServiceRestrictionStatus result;

  const ServiceRestrictionRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(result.isBlocked ? Icons.lock_outline : Icons.lock_open,
              size: 16,
              color: result.isBlocked ? scheme.primary : scheme.onSurface.withValues(alpha: 0.5)),
          const SizedBox(width: 8),
          Expanded(
              child: Text('${result.merchantName} — ${result.serviceName}',
                  overflow: TextOverflow.ellipsis)),
          Text(result.isBlocked ? 'Blocked' : 'Allowed',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: result.isBlocked ? scheme.primary : scheme.onSurface.withValues(alpha: 0.6))),
        ],
      ),
    );
  }
}
