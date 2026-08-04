import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';

/// One-sentence read summarizing how many advertising requests are
/// awaiting admin review (Issue #401).
class BuildAdRequestNarrative {
  static String call(List<AdvertisingRequestEntity> requests) {
    if (requests.isEmpty) {
      return 'No advertising requests submitted yet.';
    }
    final pending = requests.where((r) => r.status == AdRequestStatus.pending).length;
    if (pending == 0) {
      return 'All ${requests.length} advertising request(s) have been reviewed.';
    }
    return '$pending of ${requests.length} advertising request(s) are awaiting admin review.';
  }
}
