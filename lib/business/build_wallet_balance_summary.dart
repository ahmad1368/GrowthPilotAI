import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';

/// Per-crypto-provider settled balance for the admin wallet dashboard
/// (Issue #423, acceptance criterion 5) — sums settled inflows only;
/// this app has no real wallet, so "balance" is the running total of
/// what this simulation has settled through that rail.
class BuildWalletBalanceSummary {
  static Map<BankingGatewayProvider, double> call(List<BankingGatewayTransactionEntity> transactions) {
    final balances = <BankingGatewayProvider, double>{};
    for (final t in transactions) {
      if (!t.provider.isCrypto || t.status != GatewayTransactionStatus.settled) continue;
      balances[t.provider] = (balances[t.provider] ?? 0) + t.convertedAmount;
    }
    return balances;
  }
}
