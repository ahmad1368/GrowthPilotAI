import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_bold_spans.dart';

void main() {
  group('ParseBoldSpans', () {
    test('a line with no bold markers is one plain segment', () {
      final spans = ParseBoldSpans.call('plain text');
      expect(spans, [(text: 'plain text', isBold: false)]);
    });

    test('splits text around a bold span', () {
      final spans = ParseBoldSpans.call('before **bold** after');
      expect(spans, [
        (text: 'before ', isBold: false),
        (text: 'bold', isBold: true),
        (text: ' after', isBold: false),
      ]);
    });

    test('handles multiple bold spans', () {
      final spans = ParseBoldSpans.call('**A** and **B**');
      expect(spans, [
        (text: 'A', isBold: true),
        (text: ' and ', isBold: false),
        (text: 'B', isBold: true),
      ]);
    });
  });
}
