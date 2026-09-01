/// Expiry risk tier for a perishable inventory item (Issue #438), same
/// classification shape as [ComputeComplianceRisk] but for item shelf life.
enum InventoryExpiryStatus { none, ok, expiringSoon, expired }

/// Classifies an inventory item's expiry date against a documented static
/// warning window, mirroring [ComputeComplianceRisk]'s approach — this app
/// has no live perishable-shelf-life feed to pull a per-product window
/// from.
class ComputeInventoryExpiryStatus {
  static const warningWindowDays = 7;

  static InventoryExpiryStatus call(DateTime? expiryDate, DateTime now) {
    if (expiryDate == null) return InventoryExpiryStatus.none;
    final daysLeft = expiryDate.difference(now).inDays;
    if (daysLeft < 0) return InventoryExpiryStatus.expired;
    if (daysLeft <= warningWindowDays) return InventoryExpiryStatus.expiringSoon;
    return InventoryExpiryStatus.ok;
  }
}
