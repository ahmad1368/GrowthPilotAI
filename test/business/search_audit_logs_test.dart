import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/build_audit_trail_narrative.dart';
import 'package:growth_pilot_ai/business/search_audit_logs.dart';
import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

AuditLogEntity _log({
  String adminId = 'Ahmad_Salem_Pour',
  String changeType = 'updated profile',
  String targetMerchant = 'Acme Foods',
  DateTime? timestamp,
}) =>
    AuditLogEntity(
      adminId: adminId,
      changeType: changeType,
      targetMerchant: targetMerchant,
      newValue: 'x',
      timestamp: timestamp ?? DateTime(2024, 3, 1),
    );

void main() {
  group('BuildAuditLogEntry', () {
    test('defaults to the single-admin identity when none is given', () {
      final entry = BuildAuditLogEntry.call(
          changeType: 'updated profile', targetMerchant: 'Acme Foods', newValue: '5%');

      expect(entry.adminId, 'Ahmad_Salem_Pour');
      expect(entry.previousValue, isEmpty);
    });
  });

  group('SearchAuditLogs', () {
    test('returns everything, most recent first, for blank queries', () {
      final results = SearchAuditLogs.call([
        _log(targetMerchant: 'Old', timestamp: DateTime(2024, 1, 1)),
        _log(targetMerchant: 'New', timestamp: DateTime(2024, 6, 1)),
      ], '', '');

      expect(results.first.targetMerchant, 'New');
    });

    test('filters by admin identity, case-insensitively', () {
      final results = SearchAuditLogs.call(
          [_log(adminId: 'Ahmad_Salem_Pour'), _log(adminId: 'Other_Admin')], 'ahmad', '');

      expect(results, hasLength(1));
      expect(results.single.adminId, 'Ahmad_Salem_Pour');
    });

    test('filters by target merchant, case-insensitively', () {
      final results = SearchAuditLogs.call(
          [_log(targetMerchant: 'Acme Foods'), _log(targetMerchant: 'Other Merchant')],
          '',
          'acme');

      expect(results, hasLength(1));
      expect(results.single.targetMerchant, 'Acme Foods');
    });

    test('applies both filters together', () {
      final results = SearchAuditLogs.call([
        _log(adminId: 'Ahmad_Salem_Pour', targetMerchant: 'Acme Foods'),
        _log(adminId: 'Ahmad_Salem_Pour', targetMerchant: 'Other Merchant'),
      ], 'ahmad', 'acme');

      expect(results, hasLength(1));
    });
  });

  group('BuildAuditTrailNarrative', () {
    test('falls back when no changes are logged', () {
      expect(BuildAuditTrailNarrative.call(const []), contains('No audited changes'));
    });

    test('names the most recent change', () {
      final results = SearchAuditLogs.call(
          [_log(adminId: 'Ahmad_Salem_Pour', changeType: 'updated profile', targetMerchant: 'Acme Foods')],
          '',
          '');

      final narrative = BuildAuditTrailNarrative.call(results);
      expect(narrative, contains('Ahmad_Salem_Pour'));
      expect(narrative, contains('updated profile'));
      expect(narrative, contains('Acme Foods'));
    });
  });
}
