import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/register_controller.dart';

import '../test_helpers/secure_storage_mock.dart';

/// Covers Issue #788's registration AC: validation, successful
/// persistence via the mocked secure-storage channel, and rejecting a
/// duplicate email.
void main() {
  setUp(SecureStorageMock.install);

  group('RegisterController.register() success', () {
    test('persists the new account and signs the user in', () async {
      final controller = RegisterController();
      controller.emailController.text = 'new-user@example.com';
      controller.passwordController.text = 'StrongPass1';
      controller.confirmPasswordController.text = 'StrongPass1';

      final success = await controller.register();

      expect(success, isTrue);
      expect(controller.errorMessage.value, isNull);
    });

    test('rejects registering the same email twice', () async {
      final first = RegisterController();
      first.emailController.text = 'dupe@example.com';
      first.passwordController.text = 'StrongPass1';
      first.confirmPasswordController.text = 'StrongPass1';
      expect(await first.register(), isTrue);

      final second = RegisterController();
      second.emailController.text = 'dupe@example.com';
      second.passwordController.text = 'AnotherPass1';
      second.confirmPasswordController.text = 'AnotherPass1';

      final success = await second.register();

      expect(success, isFalse);
      expect(second.errorMessage.value, isNotNull);
    });
  });

  group('RegisterController.register() validation', () {
    test('rejects mismatched passwords and sets an error message', () async {
      final controller = RegisterController();
      controller.emailController.text = 'new-user@example.com';
      controller.passwordController.text = 'StrongPass1';
      controller.confirmPasswordController.text = 'Different1';

      final success = await controller.register();

      expect(success, isFalse);
      expect(controller.errorMessage.value, isNotNull);
    });

    test('rejects an empty form', () async {
      final controller = RegisterController();

      final success = await controller.register();

      expect(success, isFalse);
      expect(controller.errorMessage.value, isNotNull);
    });
  });
}
