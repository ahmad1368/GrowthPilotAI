/// KYC workflow state (Issue #144) — named distinctly from the unrelated
/// `VerificationStatus` (transaction-to-bank matching).
enum KycVerificationStatus { none, pending, verified, rejected }
