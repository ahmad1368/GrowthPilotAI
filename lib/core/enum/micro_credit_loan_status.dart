/// Lifecycle of one short-term financing draw (Issue #419) —
/// [disbursed] until the merchant repays it ([repaid]) or the due
/// date passes unpaid ([defaulted]).
enum MicroCreditLoanStatus { disbursed, repaid, defaulted }
