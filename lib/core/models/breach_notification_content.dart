import 'package:flutter/foundation.dart';

/// PIPEDA's required disclosure elements (Issue #187, section 3) for one
/// breach notification: what happened, when, what data was involved,
/// steps taken by the company, steps for the user, and how to reach the
/// Privacy Officer.
@immutable
class BreachNotificationContent {
  final String whatHappened;
  final String whenItHappened;
  final String dataInvolved;
  final String stepsTaken;
  final String stepsForUser;
  final String contactInfo;

  const BreachNotificationContent({
    required this.whatHappened,
    required this.whenItHappened,
    required this.dataInvolved,
    required this.stepsTaken,
    required this.stepsForUser,
    required this.contactInfo,
  });
}
