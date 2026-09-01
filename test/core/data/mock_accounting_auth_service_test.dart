import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/datasources/mock_accounting_auth_service.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';

void main() {
  late MockAccountingAuthService service;

  setUp(() => service = MockAccountingAuthService());

  group('startAuthorization', () {
    test('embeds the provider scope and a CSRF state in the URL', () {
      final request = service.startAuthorization(AccountingProvider.quickbooks);
      expect(request.state, isNotEmpty);
      expect(request.authorizationUrl, contains('response_type=code'));
      expect(request.authorizationUrl,
          contains('scope=com.intuit.quickbooks.accounting'));
      expect(request.authorizationUrl, contains('state=${request.state}'));
    });

    test('uses the correct Xero scope', () {
      final request = service.startAuthorization(AccountingProvider.xero);
      expect(request.authorizationUrl,
          contains('scope=accounting.transactions.read'));
    });
  });

  group('handleCallback', () {
    test('connects when the state matches and a code is present', () async {
      final response = await service.handleCallback(
        provider: AccountingProvider.quickbooks,
        code: 'auth-code',
        returnedState: 'state-1',
        expectedState: 'state-1',
      );
      expect(response.success, isTrue);
      expect(response.data?.provider, AccountingProvider.quickbooks);
      expect(response.data?.realmId, isNotNull);
    });

    test('rejects a state mismatch as a CSRF failure (403)', () async {
      final response = await service.handleCallback(
        provider: AccountingProvider.xero,
        code: 'auth-code',
        returnedState: 'evil',
        expectedState: 'state-1',
      );
      expect(response.success, isFalse);
      expect(response.statusCode, 403);
    });

    test('rejects a missing authorization code (400)', () async {
      final response = await service.handleCallback(
        provider: AccountingProvider.xero,
        code: '',
        returnedState: 'state-1',
        expectedState: 'state-1',
      );
      expect(response.success, isFalse);
      expect(response.statusCode, 400);
    });
  });
}
