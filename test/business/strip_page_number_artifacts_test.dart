import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/strip_page_number_artifacts.dart';

void main() {
  group('StripPageNumberArtifacts', () {
    test('removes "Page X of Y" inline', () {
      expect(StripPageNumberArtifacts.call('Intro text. Page 3 of 10 more text.'),
          'Intro text.  more text.');
    });

    test('removes a lone "Page N" line', () {
      final result = StripPageNumberArtifacts.call('Body text\nPage 5\nMore text');

      expect(result, isNot(contains('Page 5')));
      expect(result, contains('Body text'));
      expect(result, contains('More text'));
    });

    test('is case-insensitive', () {
      expect(StripPageNumberArtifacts.call('PAGE 1 OF 2'), '');
    });
  });
}
