import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_urgency_tag.dart';

void main() {
  test('detects an urgency keyword case-insensitively', () {
    expect(DetectUrgencyTag.call('Need this ASAP please'), isNotNull);
  });

  test('detects "today"', () {
    expect(DetectUrgencyTag.call('Can you deliver today?'), isNotNull);
  });

  test('returns null for ordinary text', () {
    expect(DetectUrgencyTag.call('Whenever works for you is fine'), isNull);
  });
}
