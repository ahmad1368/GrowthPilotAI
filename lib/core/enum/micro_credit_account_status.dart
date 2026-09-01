/// Whether a merchant's micro-credit facility can currently disburse
/// new loans (Issue #419, acceptance criterion 5) — [suspended] is
/// only reached via [SuspendCreditAccount], triggered by a defaulted
/// loan.
enum MicroCreditAccountStatus { active, suspended }
