import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_mass_data_export.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';

SecurityAuditLogEntity _export(DateTime at) => SecurityAuditLogEntity(
      dbActionType: SecurityAuditActionType.dataExport.index,
      dbStatus: SecurityAuditStatus.success.index,
      occurredAt: at,
      platform: 'android',
    );

void main() {
  group('DetectMassDataExport', () {
    final now = DateTime(2026, 1, 1, 12, 0);

    test('true when exports within the window meet the threshold', () {
      final logs = List.generate(5, (i) => _export(now.subtract(Duration(minutes: i))));

      expect(DetectMassDataExport.call(logs, now, threshold: 5), isTrue);
    });

    test('false when below the threshold', () {
      final logs = List.generate(3, (i) => _export(now.subtract(Duration(minutes: i))));

      expect(DetectMassDataExport.call(logs, now, threshold: 5), isFalse);
    });

    test('exports outside the window do not count', () {
      final logs = List.generate(5, (i) => _export(now.subtract(const Duration(hours: 1))));

      expect(DetectMassDataExport.call(logs, now, threshold: 5, window: const Duration(minutes: 10)),
          isFalse);
    });
  });
}
