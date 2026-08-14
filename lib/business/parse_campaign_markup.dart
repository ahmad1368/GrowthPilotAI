import 'package:growth_pilot_ai/core/models/rich_text_segment.dart';

/// Parses the lightweight `**bold**`/`_italic_` markup used by the
/// campaign email composer (Issue #407, acceptance criterion 1) into
/// styled segments — this app has no WYSIWYG/HTML editor dependency,
/// so formatting is a simple non-nested token scan instead.
class ParseCampaignMarkup {
  static final _token = RegExp(r'\*\*(.+?)\*\*|_(.+?)_');

  static List<RichTextSegment> call(String markup) {
    final segments = <RichTextSegment>[];
    var cursor = 0;
    for (final match in _token.allMatches(markup)) {
      if (match.start > cursor) {
        segments.add(RichTextSegment(markup.substring(cursor, match.start)));
      }
      final bold = match.group(1);
      if (bold != null) {
        segments.add(RichTextSegment(bold, bold: true));
      } else {
        segments.add(RichTextSegment(match.group(2)!, italic: true));
      }
      cursor = match.end;
    }
    if (cursor < markup.length) {
      segments.add(RichTextSegment(markup.substring(cursor)));
    }
    return segments;
  }
}
