import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_location_tags.dart';

void main() {
  test('detects a known neighborhood mention', () {
    final tags = DetectLocationTags.call('Can we meet at Guildford Town Centre?');
    expect(tags.map((t) => t.label), contains('Guildford'));
  });

  test('detects multiple neighborhoods in one message', () {
    final tags = DetectLocationTags.call('Whalley or Newton both work for me');
    expect(tags.map((t) => t.label).toSet(), {'Whalley', 'Newton'});
  });

  test('returns nothing for a message with no known neighborhood', () {
    expect(DetectLocationTags.call('Let us meet downtown'), isEmpty);
  });
}
