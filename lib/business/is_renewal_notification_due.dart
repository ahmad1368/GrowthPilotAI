/// "Automated billing renewal notifications 3 days before charge"
/// (Issue #150 AC) — [SubscriptionRenewalHandler] dispatches through
/// #71's [NotificationChannel] once this flips true.
class IsRenewalNotificationDue {
  static const leadTime = Duration(days: 3);

  static bool call(DateTime currentPeriodEnd, DateTime now) {
    final notifyFrom = currentPeriodEnd.subtract(leadTime);
    return !now.isBefore(notifyFrom) && now.isBefore(currentPeriodEnd);
  }
}
