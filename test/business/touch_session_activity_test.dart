import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/create_auth_session.dart';
import 'package:growth_pilot_ai/business/touch_session_activity.dart';

void main() {
  test('updates lastActiveAt to the given time', () {
    final createdAt = DateTime(2026, 1, 1);
    final session = CreateAuthSession.call('This Device', createdAt).session;
    expect(session.lastActiveAt, createdAt);

    final touchedAt = DateTime(2026, 1, 5);
    TouchSessionActivity.call(session, touchedAt);

    expect(session.lastActiveAt, touchedAt);
  });
}
