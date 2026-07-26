import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the supplier directory rows + a quick-add button (Issue #442).
/// Shows every supplier (active and archived, so "Restore" stays reachable)
/// — the active-only filter is for the item-association picker instead.
/// Purely presentational — [SupplierBody] owns the vendor list.
class SupplierView extends StatelessWidget {
  final List<VendorEntity> vendors;
  final VoidCallback onAddSupplier;
  final ValueChanged<VendorEntity> onToggleArchive;

  const SupplierView({
    super.key,
    required this.vendors,
    required this.onAddSupplier,
    required this.onToggleArchive,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sorted = [...vendors]..sort((a, b) => a.name.compareTo(b.name));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text('Contacts, payment terms, and lead times',
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(fontSize: 12, color: scheme.onSurface.withValues(alpha: 0.6))),
            ),
            ShadButton.outline(
              onPressed: onAddSupplier,
              child: Text('+ Supplier', style: TextStyle(color: scheme.onSurface)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (sorted.isEmpty)
          const Text('No suppliers added yet.')
        else
          for (final v in sorted) SupplierRow(vendor: v, onToggleArchive: () => onToggleArchive(v)),
      ],
    );
  }
}
