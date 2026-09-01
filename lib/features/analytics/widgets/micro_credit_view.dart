import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_micro_credit_narrative.dart';
import 'package:growth_pilot_ai/business/compute_available_credit.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_account_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_loan_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the facility summary, financing button, loan list, and a
/// narrative (Issue #419). Purely presentational.
class MicroCreditView extends StatelessWidget {
  final MicroCreditAccountEntity account;
  final List<MicroCreditLoanEntity> loans;
  final VoidCallback onRequestFinancing;
  final void Function(MicroCreditLoanEntity) onRepay;
  final void Function(MicroCreditLoanEntity) onFlagDefault;

  const MicroCreditView({
    super.key,
    required this.account,
    required this.loans,
    required this.onRequestFinancing,
    required this.onRepay,
    required this.onFlagDefault,
  });

  @override
  Widget build(BuildContext context) {
    final available = ComputeAvailableCredit.call(account, loans);
    final canBorrow = account.status == MicroCreditAccountStatus.active && available > 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            'Limit \$${account.creditLimit.toStringAsFixed(2)} — '
            'available \$${available.toStringAsFixed(2)} — ${account.status.name}',
            style: const TextStyle(fontSize: 12)),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          if (canBorrow)
            ShadButton.outline(onPressed: onRequestFinancing, child: const Text('+ Request Financing')),
        ]),
        for (final loan in loans)
          MicroCreditLoanRow(
              loan: loan, onRepay: () => onRepay(loan), onFlagDefault: () => onFlagDefault(loan)),
        const SizedBox(height: 8),
        Text(BuildMicroCreditNarrative.call(loans)),
      ],
    );
  }
}
