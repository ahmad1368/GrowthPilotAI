import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_account_suspension_statuses.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/account_suspension_repository.dart';
import 'package:growth_pilot_ai/core/models/account_suspension_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/account_suspension_view.dart';

/// Owns the suspension list (Issue #341), refreshing it locally after
/// each new suspension or manual lift — mirrors [ServiceRestrictionBody].
class AccountSuspensionBody extends StatefulWidget {
  final List<AccountSuspensionEntity> initialSuspensions;

  const AccountSuspensionBody({super.key, required this.initialSuspensions});

  @override
  State<AccountSuspensionBody> createState() => _AccountSuspensionBodyState();
}

class _AccountSuspensionBodyState extends State<AccountSuspensionBody> {
  late List<AccountSuspensionEntity> _suspensions = widget.initialSuspensions;

  Future<void> _addSuspension() async {
    final suspension = await showAccountSuspensionDialog(context);
    if (suspension == null) return;
    AccountSuspensionRepository(
            Get.find<ObjectBox>().store.box<AccountSuspensionEntity>())
        .save(suspension);
    setState(() => _suspensions = [..._suspensions, suspension]);
  }

  void _lift(AccountSuspensionStatus status) {
    final repo = AccountSuspensionRepository(
        Get.find<ObjectBox>().store.box<AccountSuspensionEntity>());
    final lifted = AccountSuspensionEntity(
      id: status.id,
      merchantName: status.merchantName,
      reason: status.reason,
      suspendedAt: status.suspendedAt,
      expiresAt: status.expiresAt,
      isManuallyLifted: true,
    );
    repo.save(lifted);
    setState(() => _suspensions = [
          for (final s in _suspensions)
            if (s.id != lifted.id) s,
          lifted,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeAccountSuspensionStatuses.call(_suspensions, DateTime.now());
    return AccountSuspensionView(
      results: results,
      onSuspend: _addSuspension,
      onLift: _lift,
    );
  }
}
