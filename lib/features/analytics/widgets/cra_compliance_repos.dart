import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/cra_transaction_log_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/banking_gateway_transaction_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/cra_transaction_log_repository.dart';
import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// Bundles the repositories and cipher the CRA compliance engine
/// needs (Issue #428) — reuses [BankingGatewayTransactionRepository]
/// (#421-423) as the settlement source.
class CraComplianceRepos {
  final store = Get.find<ObjectBox>().store;

  late final gatewayTransactions =
      BankingGatewayTransactionRepository(store.box<BankingGatewayTransactionEntity>());
  late final logs = CraTransactionLogRepository(store.box<CraTransactionLogEntity>());
  final cipher = FieldCipher();
}
