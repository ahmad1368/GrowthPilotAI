import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_message_tags.dart';
import 'package:growth_pilot_ai/core/enum/metadata_tag_category.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

void main() {
  test('combines financial, location, and urgency detections', () {
    final tags = ExtractMessageTags.call('Need it ASAP for \$150, drop off at Guildford');
    final categories = tags.map((t) => t.category).toSet();
    expect(categories, {
      MetadataTagCategory.financial,
      MetadataTagCategory.location,
      MetadataTagCategory.urgency,
    });
  });

  test('returns an empty list for plain conversational text', () {
    expect(ExtractMessageTags.call('Sounds great, talk soon!'), isEmpty);
  });

  test('display labels are hashtag-formatted with no spaces', () {
    final tags = ExtractMessageTags.call('Meet at Guildford Town Centre');
    expect(tags.map(messageTagDisplayLabel), contains('#Guildford'));
  });
}
