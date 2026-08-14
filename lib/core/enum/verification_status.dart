/// Verification state of a transaction. Moves to [verified] once the AI matches
/// an invoice to a bank transaction; [flagged] marks an anomaly for review.
enum VerificationStatus { pending, verified, flagged }
