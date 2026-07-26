import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/vendor_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/supplier_view.dart';

/// Owns the supplier list (Issue #442), refreshing it locally after each
/// quick-add insert or archive/restore toggle. Rendering itself is
/// [SupplierView]'s job.
class SupplierBody extends StatefulWidget {
  final List<VendorEntity> initialVendors;

  const SupplierBody({super.key, required this.initialVendors});

  @override
  State<SupplierBody> createState() => _SupplierBodyState();
}

class _SupplierBodyState extends State<SupplierBody> {
  late List<VendorEntity> _vendors = widget.initialVendors;

  Future<void> _addSupplier() async {
    final vendor = await showSupplierDialog(context);
    if (vendor == null) return;
    VendorRepository(Get.find<ObjectBox>().store.box<VendorEntity>()).insert(vendor);
    setState(() => _vendors = [..._vendors, vendor]);
  }

  void _toggleArchive(VendorEntity vendor) {
    vendor.isActive = !vendor.isActive;
    VendorRepository(Get.find<ObjectBox>().store.box<VendorEntity>()).insert(vendor);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => SupplierView(
      vendors: _vendors, onAddSupplier: _addSupplier, onToggleArchive: _toggleArchive);
}
