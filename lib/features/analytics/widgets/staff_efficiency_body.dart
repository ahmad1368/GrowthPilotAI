import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_staff_efficiency.dart';
import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/staff_shift_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_shift_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/staff_efficiency_view.dart';

/// Owns the logged-shift list (Issue #379), refreshing it locally after
/// each quick-add insert — mirrors [DiscountCampaignImpactBody]'s pattern.
class StaffEfficiencyBody extends StatefulWidget {
  final List<StaffShiftEntity> initialShifts;
  final List<TransactionEntity> transactions;

  const StaffEfficiencyBody(
      {super.key, required this.initialShifts, required this.transactions});

  @override
  State<StaffEfficiencyBody> createState() => _StaffEfficiencyBodyState();
}

class _StaffEfficiencyBodyState extends State<StaffEfficiencyBody> {
  late List<StaffShiftEntity> _shifts = widget.initialShifts;

  Future<void> _addShift() async {
    final shift = await showStaffShiftDialog(context);
    if (shift == null) return;
    StaffShiftRepository(Get.find<ObjectBox>().store.box<StaffShiftEntity>())
        .insert(shift);
    setState(() => _shifts = [..._shifts, shift]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeStaffEfficiency.call(_shifts, widget.transactions);
    return StaffEfficiencyView(results: results, onAddShift: _addShift);
  }
}
