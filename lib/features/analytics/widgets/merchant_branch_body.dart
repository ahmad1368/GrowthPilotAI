import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_multi_merchant_overview.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_branch_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/merchant_branch_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/merchant_branch_view.dart';

/// Owns the logged-branch list (Issue #400), refreshing it locally after
/// each quick-add insert — mirrors [NeighborhoodExpansionBody]'s pattern.
class MerchantBranchBody extends StatefulWidget {
  final List<MerchantBranchEntity> initialBranches;

  const MerchantBranchBody({super.key, required this.initialBranches});

  @override
  State<MerchantBranchBody> createState() => _MerchantBranchBodyState();
}

class _MerchantBranchBodyState extends State<MerchantBranchBody> {
  late List<MerchantBranchEntity> _branches = widget.initialBranches;

  Future<void> _addBranch() async {
    final branch = await showMerchantBranchDialog(context);
    if (branch == null) return;
    MerchantBranchRepository(
            Get.find<ObjectBox>().store.box<MerchantBranchEntity>())
        .insert(branch);
    setState(() => _branches = [..._branches, branch]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeMultiMerchantOverview.call(_branches);
    return MerchantBranchView(results: results, onAddBranch: _addBranch);
  }
}
