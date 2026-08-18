/// Strips "Page X of Y" artifacts (Issue #227's own example pattern).
class StripPageNumberArtifacts {
  static final _pageOfPattern = RegExp(r'\bpage\s+\d+\s+of\s+\d+\b', caseSensitive: false);
  static final _lonePageNumber =
      RegExp(r'^\s*page\s+\d+\s*$', caseSensitive: false, multiLine: true);

  static String call(String text) {
    final withoutPageOf = text.replaceAll(_pageOfPattern, '');
    return withoutPageOf.replaceAll(_lonePageNumber, '');
  }
}
