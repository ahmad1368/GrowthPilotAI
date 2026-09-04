import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_local_login.dart';
import 'package:growth_pilot_ai/core/constants/demo_credentials.dart';

void main() {
  group('ValidateLocalLogin', () {
    test('accepts the exact trusted demo credentials', () {
      expect(
        ValidateLocalLogin.call(
            DemoCredentials.email, DemoCredentials.password),
        isTrue,
      );
    });

    test('is case-insensitive and trims whitespace on the email', () {
      expect(
        ValidateLocalLogin.call(
            '  ${DemoCredentials.email.toUpperCase()}  ',
            DemoCredentials.password),
        isTrue,
      );
    });

    test('rejects a wrong password', () {
      expect(
        ValidateLocalLogin.call(DemoCredentials.email, 'wrong-password'),
        isFalse,
      );
    });

    test('rejects a wrong email', () {
      expect(
        ValidateLocalLogin.call('someone@else.com', DemoCredentials.password),
        isFalse,
      );
    });

    test('rejects empty input', () {
      expect(ValidateLocalLogin.call('', ''), isFalse);
    });
  });
}
