import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_active_suppliers.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Supplier picker for associating an inventory item with the vendor it's
/// sourced from (Issue #442). Archived suppliers are excluded — they
/// shouldn't take on new item associations.
class InventoryItemVendorField extends StatelessWidget {
  final List<VendorEntity> vendors;
  final VendorEntity? selectedVendor;
  final ValueChanged<VendorEntity?> onVendorChanged;

  const InventoryItemVendorField({
    super.key,
    required this.vendors,
    required this.selectedVendor,
    required this.onVendorChanged,
  });

  @override
  Widget build(BuildContext context) {
    final active = ComputeActiveSuppliers.call(vendors);

    return ShadSelect<VendorEntity?>(
      initialValue: selectedVendor,
      placeholder: const Text('Supplier (optional)'),
      options: [
        const ShadOption(value: null, child: Text('None')),
        for (final v in active) ShadOption(value: v, child: Text(v.name)),
      ],
      selectedOptionBuilder: (context, value) => Text(value?.name ?? 'None'),
      onChanged: onVendorChanged,
    );
  }
}
