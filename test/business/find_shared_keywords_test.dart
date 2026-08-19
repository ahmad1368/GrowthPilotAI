import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_shared_keywords.dart';

void main() {
  group('FindSharedKeywords', () {
    test('returns the significant words present in both texts', () {
      final result = FindSharedKeywords.call(
          'Reduce customer wait time', 'The system shall reduce customer wait time via automation');

      expect(result, containsAll(['reduce', 'customer', 'wait']));
    });

    test('excludes short words and stopwords', () {
      final result = FindSharedKeywords.call('The system must support this', 'The system must support this');

      expect(result, isEmpty);
    });

    test('returns an empty list when nothing overlaps', () {
      expect(FindSharedKeywords.call('Alpha bravo charlie', 'Delta echo foxtrot'), isEmpty);
    });
  });
}
