/// "Frequency Analysis" (Issue #98 scope item 3): flags an account
/// posting faster than a reasonable human rate, preventing it from
/// skewing neighborhood demand stats.
class IsSpamFrequency {
  static bool call(int postsInLastHour, {int maxPostsPerHour = 20}) =>
      postsInLastHour > maxPostsPerHour;
}
