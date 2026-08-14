import 'package:growth_pilot_ai/core/models/service_restriction_status.dart';

/// One-sentence read summarizing how many merchant/service pairs are
/// currently locked and naming the most recent lockdown (Issue #337).
class BuildServiceRestrictionNarrative {
  static String call(List<ServiceRestrictionStatus> results) {
    if (results.isEmpty) {
      return 'No service restrictions logged yet — block a service to start enforcing access.';
    }
    final blocked = results.where((r) => r.isBlocked);
    if (blocked.isEmpty) {
      return 'No services are currently locked out of ${results.length} logged.';
    }
    final latest = blocked.first;
    return '${blocked.length} of ${results.length} logged service(s) are locked — most '
        'recently "${latest.serviceName}" for ${latest.merchantName} '
        '("${latest.reasonMessage}").';
  }
}
