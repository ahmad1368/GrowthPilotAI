import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/merchant_tag_summary.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One merchant's profile with its assigned tag chips (Issue #342).
class MerchantTagRow extends StatelessWidget {
  final MerchantTagSummary result;

  const MerchantTagRow({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text('${result.businessName} (${result.businessId})',
                  overflow: TextOverflow.ellipsis)),
          Wrap(
            spacing: 4,
            children: [
              for (final tag in result.tags) ShadBadge.outline(child: Text(tag)),
            ],
          ),
        ],
      ),
    );
  }
}
