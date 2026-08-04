import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/apply_cap_expansion_decision.dart';
import 'package:growth_pilot_ai/business/check_daily_cap_breach.dart';
import 'package:growth_pilot_ai/business/compute_daily_transaction_total.dart';
import 'package:growth_pilot_ai/business/dispatch_daily_cap_breach_notification.dart';
import 'package:growth_pilot_ai/core/data/entities/cap_expansion_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/daily_transaction_cap_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inbox_notification_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/cap_expansion_request_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/daily_transaction_cap_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/inbox_notification_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cap_expansion_request_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/daily_cap_view.dart';

/// Owns the cap value and expansion requests (Issue #344), dispatching a
/// local Inbox notification the first time today's total breaches the
/// cap so new transactions being blocked doesn't happen silently.
class DailyCapBody extends StatefulWidget {
  final List<TransactionEntity> transactions;
  final double initialCapAmount;
  final List<CapExpansionRequestEntity> initialRequests;

  const DailyCapBody({
    super.key,
    required this.transactions,
    required this.initialCapAmount,
    required this.initialRequests,
  });

  @override
  State<DailyCapBody> createState() => _DailyCapBodyState();
}

class _DailyCapBodyState extends State<DailyCapBody> {
  late double _capAmount = widget.initialCapAmount;
  late List<CapExpansionRequestEntity> _requests = widget.initialRequests;

  void _saveCap(double value) {
    DailyTransactionCapRepository(Get.find<ObjectBox>().store.box<DailyTransactionCapEntity>())
        .save(DailyTransactionCapEntity(capAmount: value));
    setState(() => _capAmount = value);
  }

  Future<void> _requestIncrease() async {
    final request = await showCapExpansionRequestDialog(context);
    if (request == null) return;
    CapExpansionRequestRepository(
            Get.find<ObjectBox>().store.box<CapExpansionRequestEntity>())
        .save(request);
    setState(() => _requests = [..._requests, request]);
  }

  void _decide(CapExpansionRequestEntity request, bool approved) {
    final store = Get.find<ObjectBox>().store;
    final decided = ApplyCapExpansionDecision.call(request, approved);
    CapExpansionRequestRepository(store.box<CapExpansionRequestEntity>()).save(decided);
    if (approved) _saveCap(request.requestedCapAmount);
    setState(() => _requests = [
          for (final r in _requests)
            if (r.id != decided.id) r,
          decided,
        ]);
  }

  void _dispatchBreachNotice(bool isBlocked, double dailyTotal, DateTime today) {
    final store = Get.find<ObjectBox>().store;
    final inbox = InboxNotificationRepository(store.box<InboxNotificationEntity>());
    final existingIds = inbox
        .getAll()
        .where((n) => n.metadataRefType == 'DailyCap')
        .map((n) => n.metadataRefId ?? '')
        .toSet();
    final notice = DispatchDailyCapBreachNotification.call(
      isBlocked: isBlocked,
      dailyTotal: dailyTotal,
      capAmount: _capAmount,
      day: today,
      alreadyDispatchedIds: existingIds,
    );
    if (notice != null) inbox.upsert(notice);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final dailyTotal = ComputeDailyTransactionTotal.call(widget.transactions, today);
    final isBlocked = CheckDailyCapBreach.call(dailyTotal, _capAmount);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _dispatchBreachNotice(isBlocked, dailyTotal, today));
    return DailyCapView(
      capAmount: _capAmount,
      dailyTotal: dailyTotal,
      isBlocked: isBlocked,
      requests: _requests,
      onCapSaved: _saveCap,
      onRequestIncrease: _requestIncrease,
      onDecision: _decide,
    );
  }
}
