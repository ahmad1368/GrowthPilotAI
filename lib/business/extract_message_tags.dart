import 'package:growth_pilot_ai/business/detect_financial_tag.dart';
import 'package:growth_pilot_ai/business/detect_location_tags.dart';
import 'package:growth_pilot_ai/business/detect_urgency_tag.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

/// "Metadata Extraction Service" (Issue #128) — runs the financial,
/// location, and urgency detectors against one message body.
class ExtractMessageTags {
  static List<MessageTag> call(String content) {
    return [
      DetectFinancialTag.call(content),
      ...DetectLocationTags.call(content),
      DetectUrgencyTag.call(content),
    ].whereType<MessageTag>().toList();
  }
}
