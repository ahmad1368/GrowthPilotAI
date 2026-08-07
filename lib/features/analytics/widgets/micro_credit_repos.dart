import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_account_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/audit_log_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/escrow_account_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/micro_credit_account_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/micro_credit_loan_repository.dart';

/// Bundles the repositories the micro-credit facility needs (Issue
/// #419) — reuses [EscrowAccountRepository] (#415) as the
/// disbursement rail, mirroring [InventoryRecommendationRepos]'s
/// cross-feature reuse pattern.
class MicroCreditRepos {
  final store = Get.find<ObjectBox>().store;

  late final accounts = MicroCreditAccountRepository(store.box<MicroCreditAccountEntity>());
  late final loans = MicroCreditLoanRepository(store.box<MicroCreditLoanEntity>());
  late final escrowAccounts = EscrowAccountRepository(store.box<EscrowAccountEntity>());
  late final auditLogs = AuditLogRepository(store.box<AuditLogEntity>());
}
