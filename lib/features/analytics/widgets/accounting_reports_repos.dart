import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/commission_tier_record_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/fee_waiver_record_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/banking_gateway_transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/commission_tier_record_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/fee_waiver_record_repository.dart';

/// Bundles the repositories the accounting report needs (Issue #427)
/// — purely a read layer over the existing commission (#425),
/// fee-waiver (#420), and banking-gateway (#421-423) ledgers.
class AccountingReportsRepos {
  final store = Get.find<ObjectBox>().store;

  late final commissionRecords =
      CommissionTierRecordRepository(store.box<CommissionTierRecordEntity>());
  late final waiverRecords = FeeWaiverRecordRepository(store.box<FeeWaiverRecordEntity>());
  late final gatewayTransactions =
      BankingGatewayTransactionRepository(store.box<BankingGatewayTransactionEntity>());
}
