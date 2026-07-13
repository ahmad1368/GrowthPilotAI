import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/models/accounting_integration.dart';
import 'package:growth_pilot_ai/core/models/authorization_request.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for the QuickBooks/Xero OAuth 2.0 connect flow. The client builds
/// the authorization request and verifies the callback; the backend performs
/// the code-for-token exchange (tokens never reach the client).
abstract class AccountingAuthService {
  AuthorizationRequest startAuthorization(AccountingProvider provider);

  OmniResult<AccountingIntegration> handleCallback({
    required AccountingProvider provider,
    required String code,
    required String returnedState,
    required String expectedState,
  });
}
