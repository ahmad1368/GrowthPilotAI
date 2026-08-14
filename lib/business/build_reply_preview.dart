/// Denormalized "Preview String" for a reply's parent message (Issue
/// #132 "Optimization" constraint: avoid a lookup at render time by
/// storing the first 50 chars instead).
class BuildReplyPreview {
  static const int maxLength = 50;

  static String call(String body) =>
      body.length <= maxLength ? body : '${body.substring(0, maxLength)}…';
}
