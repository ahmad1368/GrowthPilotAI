/// True when [nowMinutes] (minutes-since-midnight, local time) falls
/// inside a quiet window (Issue #159) — handles a window that spans
/// midnight (e.g. 22:00-08:00) the same as one that doesn't. A
/// zero-width window (`start == end`) is treated as "no quiet hours".
class IsWithinQuietHours {
  static bool call(int nowMinutes, int startMinutes, int endMinutes) {
    if (startMinutes == endMinutes) return false;
    if (startMinutes < endMinutes) {
      return nowMinutes >= startMinutes && nowMinutes < endMinutes;
    }
    return nowMinutes >= startMinutes || nowMinutes < endMinutes;
  }
}
