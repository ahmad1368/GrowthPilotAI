/// Plaid product scopes this app requests (Issue #62/#63's "Data
/// Minimization" AC: "Do not request investments or liabilities unless
/// explicitly needed for a future issue"). `transactions`/`auth`/
/// `identity` are the only ones enabled — deliberately not an exhaustive
/// mirror of Plaid's full product catalog.
enum PlaidProduct { transactions, auth, identity }
