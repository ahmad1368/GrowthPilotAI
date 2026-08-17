import 'package:growth_pilot_ai/core/data/entities/security_incident_entity.dart';
import 'package:growth_pilot_ai/core/models/breach_notification_content.dart';

const _defaultContactInfo =
    'Contact our Privacy Officer at privacy@growthpilot.ca to ask questions or file a complaint.';

/// Fills the "Ready-to-Use" PIPEDA disclosure template (Issue #187,
/// section 3) from a real logged incident, so a notification can never
/// omit a required legal element.
class BuildBreachNotificationContent {
  static BreachNotificationContent call(SecurityIncidentEntity incident,
      {String stepsForUser = 'Reset your password now and monitor your accounts for unusual activity.',
      String contactInfo = _defaultContactInfo}) {
    return BreachNotificationContent(
      whatHappened: incident.summary,
      whenItHappened: incident.detectedAt.toIso8601String(),
      dataInvolved: incident.dataInvolved,
      stepsTaken: 'Status: ${incident.status.name}.',
      stepsForUser: stepsForUser,
      contactInfo: contactInfo,
    );
  }
}
