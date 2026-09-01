/// Splits `**bold**`-marked text into plain segments (Issue #200's
/// "Markdown Support" AC) — a lightweight inline-bold parser, not a
/// full CommonMark implementation (see PR notes for why
/// `flutter_markdown` wasn't added as a dependency).
class ParseBoldSpans {
  static final _pattern = RegExp(r'\*\*(.+?)\*\*');

  static List<({String text, bool isBold})> call(String line) {
    final spans = <({String text, bool isBold})>[];
    var cursor = 0;
    for (final match in _pattern.allMatches(line)) {
      if (match.start > cursor) {
        spans.add((text: line.substring(cursor, match.start), isBold: false));
      }
      spans.add((text: match.group(1)!, isBold: true));
      cursor = match.end;
    }
    if (cursor < line.length) {
      spans.add((text: line.substring(cursor), isBold: false));
    }
    return spans;
  }
}
