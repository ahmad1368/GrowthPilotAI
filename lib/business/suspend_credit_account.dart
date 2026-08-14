import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_account_status.dart';

/// Suspends further disbursements after a payment failure (Issue
/// #419, acceptance criterion 5) — the app's default-risk control,
/// triggered alongside [FlagLoanDefault].
class SuspendCreditAccount {
  static MicroCreditAccountEntity call(MicroCreditAccountEntity account) {
    return MicroCreditAccountEntity(
      id: account.id,
      merchantName: account.merchantName,
      creditLimit: account.creditLimit,
      dbStatus: MicroCreditAccountStatus.suspended.index,
      createdAt: account.createdAt,
    );
  }
}
