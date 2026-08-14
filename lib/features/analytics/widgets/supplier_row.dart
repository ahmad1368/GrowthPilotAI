import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One supplier's directory row (Issue #442): contact/terms/lead-time
/// details + an archive/restore toggle.
class SupplierRow extends StatelessWidget {
  final VendorEntity vendor;
  final VoidCallback onToggleArchive;

  const SupplierRow({super.key, required this.vendor, required this.onToggleArchive});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final nameAlpha = vendor.isActive ? 1.0 : 0.4;
    final mutedStyle =
        TextStyle(fontSize: 11, color: scheme.onSurface.withValues(alpha: 0.5 * nameAlpha));
    final details = <String>[
      if (vendor.contactInfo.isNotEmpty) vendor.contactInfo,
      if (vendor.paymentTerms.isNotEmpty) vendor.paymentTerms,
      if (vendor.typicalLeadTimeDays > 0) '${vendor.typicalLeadTimeDays}d lead time',
      if (!vendor.isActive) 'Archived',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vendor.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: scheme.onSurface.withValues(alpha: nameAlpha))),
                if (details.isNotEmpty)
                  Text(details.join(' · '), overflow: TextOverflow.ellipsis, style: mutedStyle),
              ],
            ),
          ),
          ShadButton.ghost(
            onPressed: onToggleArchive,
            child: Text(vendor.isActive ? 'Archive' : 'Restore',
                style: TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.7))),
          ),
        ],
      ),
    );
  }
}
