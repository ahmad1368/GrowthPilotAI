import 'package:growth_pilot_ai/core/enum/metadata_tag_category.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

/// Flags time-pressure language (Issue #128's own "#UrgentDelivery"
/// example tag) via a fixed keyword list.
class DetectUrgencyTag {
  static const _keywords = ['urgent', 'asap', 'today', 'tomorrow', 'right away'];

  static MessageTag? call(String content) {
    final lower = content.toLowerCase();
    if (!_keywords.any(lower.contains)) return null;
    return (category: MetadataTagCategory.urgency, label: 'UrgentDelivery', confidence: 0.8);
  }
}
