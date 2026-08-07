import 'package:growth_pilot_ai/business/compute_micro_credit_limit.dart';
import 'package:growth_pilot_ai/business/compute_trailing_revenue.dart';
import 'package:growth_pilot_ai/business/suspend_credit_account.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/micro_credit_repos.dart';

/// Instant credit-limit provisioning and suspension (Issue #419,
/// acceptance criteria 1 and 5) — split out of [MicroCreditBody].
class MicroCreditAccountActions {
  final MicroCreditRepos repos;

  MicroCreditAccountActions(this.repos);

  /// Finds this merchant's existing facility or instantly provisions
  /// one from trailing revenue — there is no manual application step.
  MicroCreditAccountEntity findOrCreate(
      String merchantName, List<TransactionEntity> transactions) {
    final existing =
        repos.accounts.getAll().where((a) => a.merchantName == merchantName).firstOrNull;
    if (existing != null) return existing;

    final revenue = ComputeTrailingRevenue.call(transactions, DateTime.now());
    final account = MicroCreditAccountEntity(
      merchantName: merchantName,
      creditLimit: ComputeMicroCreditLimit.call(revenue, const []),
      createdAt: DateTime.now(),
    );
    repos.accounts.save(account);
    return account;
  }

  MicroCreditAccountEntity suspend(MicroCreditAccountEntity account) {
    final updated = SuspendCreditAccount.call(account);
    repos.accounts.save(updated);
    return updated;
  }
}
