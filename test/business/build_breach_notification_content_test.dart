import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_breach_notification_content.dart';
import 'package:growth_pilot_ai/core/data/entities/security_incident_entity.dart';
import 'package:growth_pilot_ai/core/enum/breach_incident_status.dart';

void main() {
  group('BuildBreachNotificationContent', () {
    test('fills all six PIPEDA disclosure elements from the incident', () {
      final incident = SecurityIncidentEntity(
        summary: 'Unauthorized access to the export endpoint was detected.',
        dataInvolved: 'Names, transaction history',
        dbStatus: BreachIncidentStatus.contained.index,
        detectedAt: DateTime(2026, 1, 1, 12, 0),
      );

      final content = BuildBreachNotificationContent.call(incident);

      expect(content.whatHappened, incident.summary);
      expect(content.dataInvolved, 'Names, transaction history');
      expect(content.whenItHappened, incident.detectedAt.toIso8601String());
      expect(content.stepsTaken, contains('contained'));
      expect(content.stepsForUser, isNotEmpty);
      expect(content.contactInfo, contains('Privacy Officer'));
    });
  });
}
