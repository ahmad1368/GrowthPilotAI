/// CRA tax-filing category a logged transaction falls under (Issue
/// #428, acceptance criterion 2) — a coarse, rule-based classification
/// since this app has no real accounting/tax-filing integration.
enum TaxCategory { businessIncome, capitalGain, foreignExchangeGainLoss, other }
