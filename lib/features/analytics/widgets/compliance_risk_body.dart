import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/compliance_item_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_item_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_view.dart';

/// Owns the compliance-item list (Issue #392), refreshing it locally after
/// each quick-add insert. Rendering itself is [ComplianceRiskView]'s job.
class ComplianceRiskBody extends StatefulWidget {
  final List<ComplianceItemEntity> initialItems;

  const ComplianceRiskBody({super.key, required this.initialItems});

  @override
  State<ComplianceRiskBody> createState() => _ComplianceRiskBodyState();
}

class _ComplianceRiskBodyState extends State<ComplianceRiskBody> {
  late List<ComplianceItemEntity> _items = widget.initialItems;

  Future<void> _addItem() async {
    final item = await showComplianceItemDialog(context);
    if (item == null) return;
    ComplianceItemRepository(Get.find<ObjectBox>().store.box<ComplianceItemEntity>())
        .insert(item);
    setState(() => _items = [..._items, item]);
  }

  @override
  Widget build(BuildContext context) =>
      ComplianceRiskView(items: _items, onAddItem: _addItem);
}
