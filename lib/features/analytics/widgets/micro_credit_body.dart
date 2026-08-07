import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_account_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_disbursement_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_repayment_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_view.dart';

/// Owns the single-merchant credit facility and loan state (Issue
/// #419) — this app has no auth/session system, so the facility
/// defaults to the same single-merchant identity used everywhere else
/// (e.g. [BuildAuditLogEntry]'s default admin id).
class MicroCreditBody extends StatefulWidget {
  final List<TransactionEntity> transactions;
  const MicroCreditBody({super.key, required this.transactions});
  @override
  State<MicroCreditBody> createState() => _MicroCreditBodyState();
}

class _MicroCreditBodyState extends State<MicroCreditBody> {
  static const _merchantName = 'Ahmad_Salem_Pour';

  final _repos = MicroCreditRepos();
  late final _accountActions = MicroCreditAccountActions(_repos);
  late final _disbursementActions = MicroCreditDisbursementActions(_repos);
  late final _repaymentActions = MicroCreditRepaymentActions(_repos, _accountActions);
  late MicroCreditAccountEntity _account =
      _accountActions.findOrCreate(_merchantName, widget.transactions);
  late List<MicroCreditLoanEntity> _loans = _repos.loans.forAccount(_account.id);

  Future<void> _requestFinancing() async {
    final request = await showMicroCreditDialog(context);
    if (request == null) return;
    _disbursementActions.disburse(
        _account, request.sellerName, request.itemDescription, request.principal, request.termDays);
    setState(() => _loans = _repos.loans.forAccount(_account.id));
  }

  void _repay(MicroCreditLoanEntity loan) {
    _repaymentActions.repay(loan);
    setState(() => _loans = _repos.loans.forAccount(_account.id));
  }

  void _flagDefault(MicroCreditLoanEntity loan) {
    final result = _repaymentActions.flagDefault(loan, _account);
    setState(() {
      _account = result.account;
      _loans = _repos.loans.forAccount(_account.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MicroCreditView(
      account: _account,
      loans: _loans,
      onRequestFinancing: _requestFinancing,
      onRepay: _repay,
      onFlagDefault: _flagDefault,
    );
  }
}
