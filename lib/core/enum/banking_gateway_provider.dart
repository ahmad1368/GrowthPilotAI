/// A named payment rail the orchestration layer can route a
/// transaction through (Issue #421, acceptance criterion 1) — this
/// app has no real Stripe/PayPal/SWIFT/SEPA API credentials or a
/// backend to hold them, so every provider shares the same local
/// simulation; only the fee schedule in [ComputeGatewayFee] differs
/// per provider.
enum BankingGatewayProvider { stripe, paypal, swift, sepa }
