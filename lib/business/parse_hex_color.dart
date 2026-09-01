import 'package:flutter/material.dart';

/// Parses a `#RRGGBB` string into a [Color] (Issue #317 feature #25) —
/// same format/parsing as [BrandingColorSwatchRow]'s inline version
/// (Issue #257), extracted here since chat room theming is a second
/// caller.
class ParseHexColor {
  static Color call(String hex) => Color(int.parse('FF${hex.substring(1)}', radix: 16));
}
