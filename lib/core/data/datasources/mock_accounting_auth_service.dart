import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/interfaces/accounting_auth_service.dart';
import 'package:growth_pilot_ai/core/models/accounting_integration.dart';
import 'package:growth_pilot_ai/core/models/authorization_request.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/core/utils/oauth_state.dart';

/// Local stand-in for the QuickBooks/Xero OAuth backend. Builds a real CSRF
/// state + authorization query and emulates the code-for-token exchange
/// without a server. The auth base comes from --dart-define (no hardcoded
/// endpoint); web-safe.
class MockAccountingAuthService implements AccountingAuthService {
  static const String _authBase =
      String.fromEnvironment('ACCOUNTING_AUTH_URL');

  @override
  AuthorizationRequest startAuthorization(AccountingProvider provider) {
    final state = OAuthState.generate();
    final url = '$_authBase?response_type=code'
        '&scope=${provider.scope}&state=$state';
    return AuthorizationRequest(
        provider: provider, authorizationUrl: url, state: state);
  }

  @override
  OmniResult<AccountingIntegration> handleCallback({
    required AccountingProvider provider,
    required String code,
    required String returnedState,
    required String expectedState,
  }) async {
    if (!OAuthState.verify(returnedState, expectedState)) {
      OmniLogger.warning('OAuth callback rejected: state mismatch (CSRF)');
      return OmniResponse.error('Invalid state (CSRF check failed)',
          statusCode: 403);
    }
    if (code.isEmpty) {
      return OmniResponse.error('Missing authorization code', statusCode: 400);
    }
    final integration = AccountingIntegration(
        provider: provider,
        realmId: provider == AccountingProvider.quickbooks
            ? 'mock-realm-123'
            : null);
    OmniLogger.info('${provider.label} connected');
    return OmniResponse.success(integration, message: 'Connected');
  }
}
