/// Pure math for how much of an item is actually sellable right now (Issue
/// #445): quantity on hand minus whatever is already held by active
/// online-checkout reservations.
class ComputeAvailableQuantity {
  static int call(int quantityOnHand, List<int> activeReservationQuantities) {
    final reserved = activeReservationQuantities.fold<int>(0, (sum, q) => sum + q);
    return quantityOnHand - reserved;
  }
}
