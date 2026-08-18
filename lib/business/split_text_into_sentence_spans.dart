import 'package:growth_pilot_ai/core/models/source_text_span.dart';

/// Splits sanitized text into sentences, tracking each one's character
/// offset in the source (Issue #228's `start_index`/`end_index`) — the
/// unit [ExtractRequirementsFromText] scans for requirement indicators.
/// [SourceTextSpan.start]/[end] point at the trimmed sentence itself
/// (leading/trailing whitespace excluded), so `text.substring(start,
/// end)` always equals [SourceTextSpan.text].
class SplitTextIntoSentenceSpans {
  static final _sentenceEnd = RegExp(r'[.!?]');

  static List<SourceTextSpan> call(String text) {
    final spans = <SourceTextSpan>[];
    var chunkStart = 0;

    for (var i = 0; i < text.length; i++) {
      if (_sentenceEnd.hasMatch(text[i])) {
        _addTrimmedSpan(spans, text, chunkStart, i + 1);
        chunkStart = i + 1;
      }
    }
    _addTrimmedSpan(spans, text, chunkStart, text.length);
    return spans;
  }

  static void _addTrimmedSpan(List<SourceTextSpan> spans, String text, int rawStart, int rawEnd) {
    var start = rawStart;
    var end = rawEnd;
    while (start < end && text[start].trim().isEmpty) {
      start++;
    }
    while (end > start && text[end - 1].trim().isEmpty) {
      end--;
    }
    if (start < end) {
      spans.add(SourceTextSpan(text: text.substring(start, end), start: start, end: end));
    }
  }
}
