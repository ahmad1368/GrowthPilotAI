/// A merchant/service pair's current lockdown status (Issue #337): the
/// latest logged block/unblock decision and the reason shown to users
/// attempting to access that service while it's locked.
class ServiceRestrictionStatus {
  final String merchantName;
  final String serviceName;
  final bool isBlocked;
  final String reasonMessage;
  final DateTime updatedAt;

  const ServiceRestrictionStatus({
    required this.merchantName,
    required this.serviceName,
    required this.isBlocked,
    required this.reasonMessage,
    required this.updatedAt,
  });
}
