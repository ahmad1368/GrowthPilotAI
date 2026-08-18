/// "Table of Contents (which can confuse AI into thinking they are the
/// actual requirements)" (Issue #227) — drops lines matching the
/// classic dot-leader ToC pattern (e.g. "Introduction .......... 3").
class StripTableOfContentsLines {
  static final _dotLeaderPattern = RegExp(r'^.+\.{3,}\s*\d+\s*$');

  static String call(String text) {
    final lines = text.split('\n');
    final kept = lines.where((line) => !_dotLeaderPattern.hasMatch(line.trim()));
    return kept.join('\n');
  }
}
