import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/strip_table_of_contents_lines.dart';

void main() {
  group('StripTableOfContentsLines', () {
    test('removes dot-leader ToC entries', () {
      final result = StripTableOfContentsLines.call(
          'Introduction..........3\nBackground.......5\nActual requirement text here');

      expect(result, isNot(contains('Introduction')));
      expect(result, isNot(contains('Background')));
      expect(result, contains('Actual requirement text here'));
    });

    test('does not remove ordinary sentences ending in a number', () {
      final result = StripTableOfContentsLines.call('We processed 42 orders today.');

      expect(result, 'We processed 42 orders today.');
    });
  });
}
