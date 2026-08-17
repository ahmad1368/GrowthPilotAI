import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/search_security_audit_logs.dart';
import 'package:growth_pilot_ai/core/data/entities/security_audit_log_entity.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_action_type.dart';
import 'package:growth_pilot_ai/core/enum/security_audit_status.dart';

SecurityAuditLogEntity _entry(SecurityAuditActionType type, DateTime at) => SecurityAuditLogEntity(
      dbActionType: type.index,
      dbStatus: SecurityAuditStatus.success.index,
      occurredAt: at,
      platform: 'android',
    );

void main() {
  group('SearchSecurityAuditLogs', () {
    final logs = [
      _entry(SecurityAuditActionType.loginSuccess, DateTime(2026, 1, 1)),
      _entry(SecurityAuditActionType.passwordChange, DateTime(2026, 1, 5)),
      _entry(SecurityAuditActionType.loginSuccess, DateTime(2026, 1, 10)),
    ];

    test('filters by action type', () {
      final result = SearchSecurityAuditLogs.call(logs, actionType: SecurityAuditActionType.loginSuccess);

      expect(result.length, 2);
      expect(result.every((l) => l.actionType == SecurityAuditActionType.loginSuccess), isTrue);
    });

    test('filters by date range', () {
      final result =
          SearchSecurityAuditLogs.call(logs, from: DateTime(2026, 1, 3), to: DateTime(2026, 1, 8));

      expect(result.length, 1);
      expect(result.first.actionType, SecurityAuditActionType.passwordChange);
    });

    test('sorts newest first when unfiltered', () {
      final result = SearchSecurityAuditLogs.call(logs);

      expect(result.first.occurredAt, DateTime(2026, 1, 10));
      expect(result.last.occurredAt, DateTime(2026, 1, 1));
    });
  });
}
