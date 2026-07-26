/// One-line expiry readout for an inventory item, e.g. "Expires in 3d" or
/// "Expired 2d ago" (Issue #438), mirroring [ComplianceRiskRow]'s
/// days-left/overdue phrasing.
class BuildInventoryExpiryLabel {
  static String call(DateTime expiryDate, DateTime now) {
    final days = expiryDate.difference(now).inDays;
    return days < 0 ? '${-days}d expired' : 'Expires in ${days}d';
  }
}
