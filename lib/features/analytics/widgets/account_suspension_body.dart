import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/compute_account_suspension_statuses.dart';
import 'package:growth_pilot_ai/core/data/entities/account_suspension_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/account_suspension_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
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
    final store = Get.find<ObjectBox>().store;
    AccountSuspensionRepository(store.box<AccountSuspensionEntity>()).save(suspension);
    AuditLogRepository(store.box<AuditLogEntity>()).record(BuildAuditLogEntry.call(
      changeType: 'suspended account',
      targetMerchant: suspension.merchantName,
      newValue: 'until ${suspension.expiresAt} (${suspension.reason})',
    ));
    setState(() => _suspensions = [..._suspensions, suspension]);
  }

  void _lift(AccountSuspensionStatus status) {
    final store = Get.find<ObjectBox>().store;
    final repo = AccountSuspensionRepository(store.box<AccountSuspensionEntity>());
    final lifted = AccountSuspensionEntity(
      id: status.id,
      merchantName: status.merchantName,
      reason: status.reason,
      suspendedAt: status.suspendedAt,
      expiresAt: status.expiresAt,
      isManuallyLifted: true,
    );
    repo.save(lifted);
    AuditLogRepository(store.box<AuditLogEntity>()).record(BuildAuditLogEntry.call(
      changeType: 'lifted suspension',
      targetMerchant: status.merchantName,
      previousValue: 'suspended until ${status.expiresAt}',
      newValue: 'manually lifted',
    ));
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
