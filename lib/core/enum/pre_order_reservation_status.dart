/// Lifecycle of one merchant's seasonal pre-order (Issue #417) —
/// [depositPaid] on reservation, [balancePaid] once the remainder is
/// settled ahead of delivery, then [fulfilled] on delivery
/// confirmation, or [refunded] if cancelled before fulfillment.
enum PreOrderReservationStatus { depositPaid, balancePaid, fulfilled, refunded }
