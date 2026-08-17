/// Whether a user counts as "dormant" for re-engagement purposes (Issue
/// #214 AC: "Inactivity Monitor... lastActive timestamp older than 14
/// days"). No NestJS cron exists client-side to run this daily — this is
/// the pure predicate a future scheduled task (or an app-open check)
/// would apply, same pattern as [IsSessionStale] (Issue #173).
class IsUserDormant {
  static const dormantAfter = Duration(days: 14);

  static bool call(DateTime lastActiveAt, DateTime now) =>
      now.difference(lastActiveAt) >= dormantAfter;
}
