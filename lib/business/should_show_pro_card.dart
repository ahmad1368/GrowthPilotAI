/// "The system limits Pro Cards to one per week" (Issue #85 AC).
class ShouldShowProCard {
  static bool call(DateTime? lastShownAt, DateTime now, {Duration cooldown = const Duration(days: 7)}) {
    if (lastShownAt == null) return true;
    return now.difference(lastShownAt) >= cooldown;
  }
}
