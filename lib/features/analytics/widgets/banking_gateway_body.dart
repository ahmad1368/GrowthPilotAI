import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_settlement_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/banking_gateway_view.dart';

/// Owns transaction state for the banking gateway orchestration
/// simulation (Issue #421) — this app has no auth/session system, so
/// the merchant identity defaults to the same single-merchant
/// identity used everywhere else (e.g. [BuildAuditLogEntry]'s default
/// admin id).
class BankingGatewayBody extends StatefulWidget {
  const BankingGatewayBody({super.key});
  @override
  State<BankingGatewayBody> createState() => _BankingGatewayBodyState();
}

class _BankingGatewayBodyState extends State<BankingGatewayBody> {
  static const _merchantName = 'Ahmad_Salem_Pour';

  final _repos = BankingGatewayRepos();
  late final _actions = BankingGatewayActions(_repos);
  late final _settlementActions = BankingGatewaySettlementActions(_repos);
  late List<BankingGatewayTransactionEntity> _transactions = _repos.transactions.getAll();

  void _mutate(BankingGatewayTransactionEntity Function() action) {
    action();
    setState(() => _transactions = _repos.transactions.getAll());
  }

  Future<void> _create() async {
    final request = await showBankingGatewayDialog(context);
    if (request == null) return;
    _mutate(() => _actions.authorize(
        request.provider, _merchantName, request.counterpartyName, request.amount, request.currency));
  }

  @override
  Widget build(BuildContext context) {
    return BankingGatewayView(
      transactions: _transactions,
      onCreate: _create,
      onCapture: (t) => _mutate(() => _actions.capture(t)),
      onSettle: (t) => _mutate(() => _settlementActions.settle(t)),
      onFail: (t) => _mutate(() => _settlementActions.fail(t)),
      onRefund: (t) => _mutate(() => _settlementActions.refund(t)),
    );
  }
}
