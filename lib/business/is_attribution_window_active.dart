/// True while a Last-Click attribution (Issue #161) is still within its
/// 24-hour session window.
class IsAttributionWindowActive {
  static const window = Duration(hours: 24);

  static bool call(DateTime attributedAt, DateTime now) =>
      now.difference(attributedAt) < window;
}
