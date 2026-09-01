import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/record_org_action.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';

void main() {
  test('formats the audit entry as Timestamp - User - Action - Role', () {
    final now = DateTime(2026, 1, 1, 8, 30);
    final entry =
        RecordOrgAction.call('Ahmad Salem Pour', 'APPROVE_PAYMENT', MembershipRole.owner, now);

    expect(entry.userName, 'Ahmad Salem Pour');
    expect(entry.action, 'APPROVE_PAYMENT');
    expect(entry.roleUsed, MembershipRole.owner);
    expect(entry.formatted,
        '[${now.toIso8601String()}] - [Ahmad Salem Pour] - [APPROVE_PAYMENT] - [owner]');
  });
}
