/// How a merchant's commission is structured (Issue #348, acceptance
/// criterion 1) — a percentage of the transaction, or a flat fixed
/// amount per transaction regardless of size.
enum CommissionType { percentage, fixedAmount }
