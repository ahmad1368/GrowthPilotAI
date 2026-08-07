import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// One-sentence read summarizing the gateway transaction pipeline
/// (Issue #421), mirroring [BuildFeeWaiverNarrative]'s summary
/// pattern.
class BuildGatewayNarrative {
  static String call(List<BankingGatewayTransactionEntity> transactions) {
    if (transactions.isEmpty) {
      return 'No gateway transactions yet.';
    }
    final settled = transactions.where((t) => t.status == GatewayTransactionStatus.settled).length;
    final failed = transactions.where((t) => t.status == GatewayTransactionStatus.failed).length;
    return '${transactions.length} transaction(s): $settled settled, $failed failed.';
  }
}
