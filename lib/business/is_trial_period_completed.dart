/// Whether a merchant has completed the 6-month free trial period
/// (Issue #424, acceptance criterion 2) measured from [trialStartedAt].
class IsTrialPeriodCompleted {
  static const trialDurationDays = 180;

  static bool call(DateTime trialStartedAt, DateTime now) =>
      now.difference(trialStartedAt).inDays >= trialDurationDays;
}
