/// A named payment rail the orchestration layer can route a
/// transaction through (Issue #421, acceptance criterion 1) — this
/// app has no real Stripe/PayPal/SWIFT/SEPA/Interac/UnionPay API
/// credentials or a backend to hold them, so every provider shares
/// the same local simulation; only the fee schedule in
/// [ComputeGatewayFee] differs per provider. [interac], [unionPay],
/// and [localNetwork] were appended for Issue #422's regional
/// routing — new members are always added at the end so existing
/// stored `dbProvider` indices never shift.
enum BankingGatewayProvider { stripe, paypal, swift, sepa, interac, unionPay, localNetwork }
