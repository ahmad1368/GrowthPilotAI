/// Lifecycle of a simulated banking-gateway transaction (Issue
/// #421) — [authorized] then [captured] at checkout, [settled] once
/// the (simulated) webhook confirms funds landed, or [refunded]/
/// [failed] instead.
enum GatewayTransactionStatus { authorized, captured, settled, refunded, failed }
