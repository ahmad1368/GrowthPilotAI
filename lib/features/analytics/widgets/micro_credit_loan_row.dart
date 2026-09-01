import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/is_repayment_due_soon.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One loan line with repayment/default actions (Issue #419,
/// acceptance criteria 4-5) — split out of [MicroCreditView] to stay
/// under the file line cap.
class MicroCreditLoanRow extends StatelessWidget {
  final MicroCreditLoanEntity loan;
  final VoidCallback onRepay;
  final VoidCallback onFlagDefault;

  const MicroCreditLoanRow({
    super.key,
    required this.loan,
    required this.onRepay,
    required this.onFlagDefault,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final overdue = loan.status == MicroCreditLoanStatus.disbursed && now.isAfter(loan.dueDate);
    final dueSoon = IsRepaymentDueSoon.call(loan, now);
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 4),
      child: Row(children: [
        Expanded(
          child: Text(
              '\$${loan.principal.toStringAsFixed(2)} + \$${loan.feeAmount.toStringAsFixed(2)} fee, '
              'due ${loan.dueDate.toIso8601String().split('T').first} — ${loan.status.name}'
              '${overdue ? ' (overdue)' : dueSoon ? ' (due soon)' : ''}',
              style: const TextStyle(fontSize: 12)),
        ),
        if (loan.status == MicroCreditLoanStatus.disbursed) ...[
          ShadButton.ghost(onPressed: onRepay, child: const Text('Repay')),
          if (overdue)
            ShadButton.ghost(onPressed: onFlagDefault, child: const Text('Flag Default')),
        ],
      ]),
    );
  }
}
