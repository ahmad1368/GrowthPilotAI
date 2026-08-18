import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/split_text_into_sentence_spans.dart';

void main() {
  group('SplitTextIntoSentenceSpans', () {
    test('splits on sentence-ending punctuation', () {
      final spans = SplitTextIntoSentenceSpans.call('First sentence. Second sentence!');

      expect(spans.map((s) => s.text), ['First sentence.', 'Second sentence!']);
    });

    test('offsets point back into the original text', () {
      const text = 'A. B.';
      final spans = SplitTextIntoSentenceSpans.call(text);

      expect(text.substring(spans[0].start, spans[0].end), 'A.');
      expect(text.substring(spans[1].start, spans[1].end), 'B.');
    });

    test('keeps a trailing sentence with no closing punctuation', () {
      final spans = SplitTextIntoSentenceSpans.call('Ends without punctuation');

      expect(spans.single.text, 'Ends without punctuation');
    });
  });
}
