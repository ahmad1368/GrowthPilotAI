import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/login_controller.dart';
import 'package:growth_pilot_ai/core/constants/demo_credentials.dart';

/// Covers Issue #786's core AC: debug builds pre-fill trusted credentials,
/// release builds don't. `kDebugMode` itself can't be flipped at test
/// time (it's a compile-time constant, always true under `flutter test`),
/// so [LoginController] takes it as an injectable constructor param
/// (`autoFillForDebug`) — these tests exercise both branches directly.
void main() {
  group('LoginController auto-fill (Issue #786)', () {
    test('debug build pre-fills the trusted demo credentials', () {
      final controller = LoginController(autoFillForDebug: true);

      expect(controller.emailController.text, DemoCredentials.email);
      expect(controller.passwordController.text, DemoCredentials.password);
    });

    test('release build starts with empty fields', () {
      final controller = LoginController(autoFillForDebug: false);

      expect(controller.emailController.text, isEmpty);
      expect(controller.passwordController.text, isEmpty);
    });
  });

  group('LoginController.login() validation', () {
    test('rejects invalid credentials and sets an error message', () async {
      final controller = LoginController(autoFillForDebug: false);
      controller.emailController.text = 'wrong@example.com';
      controller.passwordController.text = 'nope';

      final success = await controller.login();

      expect(success, isFalse);
      expect(controller.isLoggedIn, isFalse);
      expect(controller.errorMessage.value, isNotNull);
    });
  });
}
