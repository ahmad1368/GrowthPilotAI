/// "Normalize white spaces: multiple spaces/tabs into a single space,
/// multiple newlines into a maximum of two (to preserve paragraph
/// breaks)" (Issue #227) — verbatim.
class NormalizeWhitespace {
  static final _repeatedSpacesOrTabs = RegExp(r'[ \t]+');
  static final _threeOrMoreNewlines = RegExp(r'\n{3,}');

  static String call(String text) {
    final collapsedSpaces = text.replaceAll(_repeatedSpacesOrTabs, ' ');
    return collapsedSpaces.replaceAll(_threeOrMoreNewlines, '\n\n').trim();
  }
}
