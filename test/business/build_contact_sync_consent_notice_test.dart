import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_contact_sync_consent_notice.dart';

void main() {
  test('explains hashing and the privacy controls', () {
    final notice = BuildContactSyncConsentNotice.call();
    expect(notice, contains('SHA-256'));
    expect(notice, contains('disable syncing'));
  });
}
