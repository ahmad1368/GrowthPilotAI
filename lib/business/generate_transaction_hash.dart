import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Simulated on-chain transaction hash for a crypto/stablecoin
/// settlement (Issue #423, acceptance criterion 5) — this app has no
/// real blockchain node connection, so this is a deterministic,
/// hex-shaped placeholder derived from the transaction's own inputs,
/// not a verifiable hash on any real chain. Non-crypto providers get
/// an empty string.
class GenerateTransactionHash {
  static String call(
      BankingGatewayProvider provider, String merchantName, String counterpartyName,
      double amount, DateTime now) {
    if (!provider.isCrypto) return '';
    final seed = '$provider|$merchantName|$counterpartyName|$amount|${now.microsecondsSinceEpoch}';
    final hex = StringBuffer();
    for (var i = 0; i < 5; i++) {
      final part = '${seed.hashCode ^ (i * 0x9E3779B1)}'.hashCode.abs();
      hex.write(part.toRadixString(16).padLeft(8, '0'));
    }
    return '0x${hex.toString().substring(0, 40)}';
  }
}
