/// A named payment rail the orchestration layer can route a
/// transaction through (Issue #421, acceptance criterion 1) — this
/// app has no real Stripe/PayPal/SWIFT/SEPA/Interac/UnionPay/wallet
/// credentials or a backend to hold them, so every provider shares
/// the same local simulation; only the fee schedule in
/// [ComputeGatewayFee] differs per provider. [interac], [unionPay],
/// and [localNetwork] were appended for Issue #422's regional
/// routing; [usdt], [usdc], [bitcoin], and [ethereum] were appended
/// for Issue #423's crypto/stablecoin settlement — new members are
/// always added at the end so existing stored `dbProvider` indices
/// never shift.
enum BankingGatewayProvider {
  stripe,
  paypal,
  swift,
  sepa,
  interac,
  unionPay,
  localNetwork,
  usdt,
  usdc,
  bitcoin,
  ethereum,
}

/// Whether a provider settles on a blockchain network (Issue #423) —
/// gates the gas-fee optimization, transaction-hash generation, and
/// wallet-dashboard logic that only make sense for crypto rails.
extension BankingGatewayProviderCrypto on BankingGatewayProvider {
  bool get isCrypto => switch (this) {
        BankingGatewayProvider.usdt ||
        BankingGatewayProvider.usdc ||
        BankingGatewayProvider.bitcoin ||
        BankingGatewayProvider.ethereum =>
          true,
        _ => false,
      };
}
