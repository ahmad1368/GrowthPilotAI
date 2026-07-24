/// Converts a display title into a filesystem-safe slug (Issue #117), e.g.
/// for export filenames.
class SlugifyTitle {
  static String call(String title) =>
      title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_');
}
