import 'package:growth_pilot_ai/core/enum/metadata_tag_category.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

/// "Detect Local Context" (Issue #128) — the issue's own neighborhood
/// keyword list, used as a lightweight NER stand-in (a real NER model
/// is out of scope for a local-only app).
class DetectLocationTags {
  static const neighborhoods = ['Whalley', 'Guildford', 'Newton', 'Fleetwood'];

  static List<MessageTag> call(String content) {
    return neighborhoods
        .where((area) => content.contains(area))
        .map((area) => (category: MetadataTagCategory.location, label: area, confidence: 1.0))
        .toList();
  }
}
