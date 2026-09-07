import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_login.dart';
import 'package:growth_pilot_ai/core/constants/demo_credentials.dart';

/// Covers Issue #788's core AC: the fixed demo account (Issue #786) must
/// keep working after registration support is added. The
/// locally-registered-account branch reads from secure storage (a plugin
/// channel with no platform binding under `flutter_test`), so — like
/// `login_controller_test.dart` before it — it's covered by
/// `RegisterController`/widget-level tests instead, not here.
void main() {
  group('ValidateLogin', () {
    test('accepts the fixed demo credentials', () async {
      final result = await ValidateLogin.call(
          DemoCredentials.email, DemoCredentials.password);
      expect(result, isTrue);
    });
  });
}
