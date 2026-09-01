import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';

/// Renders the matched promotion as a concluding banner (Issue #403,
/// acceptance criteria 2 and 5) — a subtle divider and label keep it
/// visually distinct from the report above without disrupting the
/// analytical reading flow, and the fade-in avoids an abrupt layout
/// jump when the recommendation resolves.
class ContextualBannerContent extends StatelessWidget {
  final AdvertisingRequestEntity request;
  final VoidCallback onTap;

  const ContextualBannerContent({super.key, required this.request, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(top: 12),
          padding: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: scheme.onSurface.withValues(alpha: 0.08))),
          ),
          child: Row(
            children: [
              Text('Sponsored: ',
                  style: TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.5))),
              Expanded(
                  child: Text('${request.merchantName} — ${request.category}',
                      overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }
}
