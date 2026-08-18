import 'package:flutter/foundation.dart';

/// A slice of source text with its character offsets (Issue #228's
/// `start_index`/`end_index`), so an extracted requirement can be
/// traced back to exactly where it came from. Named `SourceTextSpan`,
/// not `TextSpan`, to avoid colliding with `package:flutter`'s own
/// `TextSpan` (used for RichText).
@immutable
class SourceTextSpan {
  final String text;
  final int start;
  final int end;

  const SourceTextSpan({required this.text, required this.start, required this.end});
}
