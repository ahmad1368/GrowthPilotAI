import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/token_refresh_guard.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';

void main() {
  tearDown(() => TokenRefreshGuard.finish(AccountingProvider.xero));

  group('TokenRefreshGuard', () {
    test('claims the lock on first call', () {
      expect(TokenRefreshGuard.tryStart(AccountingProvider.xero), isTrue);
      expect(TokenRefreshGuard.isInProgress(AccountingProvider.xero), isTrue);
    });

    test('rejects a second concurrent claim for the same provider', () {
      TokenRefreshGuard.tryStart(AccountingProvider.xero);
      expect(TokenRefreshGuard.tryStart(AccountingProvider.xero), isFalse);
    });

    test('does not lock unrelated providers', () {
      TokenRefreshGuard.tryStart(AccountingProvider.xero);
      expect(
          TokenRefreshGuard.tryStart(AccountingProvider.quickbooks), isTrue);
      TokenRefreshGuard.finish(AccountingProvider.quickbooks);
    });

    test('finish releases the lock so it can be claimed again', () {
      TokenRefreshGuard.tryStart(AccountingProvider.xero);
      TokenRefreshGuard.finish(AccountingProvider.xero);
      expect(TokenRefreshGuard.tryStart(AccountingProvider.xero), isTrue);
    });
  });
}
