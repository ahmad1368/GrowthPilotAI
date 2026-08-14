import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/confirm_escrow_delivery.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/escrow_repos.dart';

/// Escrow account opening and delivery-confirmed release (Issue
/// #415, acceptance criteria 1-2 and 5) — split out of [EscrowBody].
class EscrowAccountActions {
  final EscrowRepos repos;

  EscrowAccountActions(this.repos);

  EscrowAccountEntity open(EscrowAccountEntity account) {
    repos.accounts.save(account);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'opened escrow account',
      targetMerchant: account.sellerName,
      newValue: '\$${account.amount.toStringAsFixed(2)} held for ${account.buyerName}',
    ));
    return account;
  }

  EscrowAccountEntity confirmDelivery(EscrowAccountEntity account) {
    final updated = ConfirmEscrowDelivery.call(account);
    repos.accounts.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'released escrow funds',
      targetMerchant: account.sellerName,
      previousValue: 'held',
      newValue: 'released \$${account.amount.toStringAsFixed(2)}',
    ));
    return updated;
  }
}
