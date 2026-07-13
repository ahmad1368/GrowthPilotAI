import 'package:growth_pilot_ai/core/models/linked_bank_account.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Contract for the Plaid bank-linking flow. A real implementation would wrap
/// `plaid_flutter` + a backend token exchange; callers stay decoupled from the
/// SDK. Tokens are opaque strings that must never be logged in plain text.
abstract class BankLinkService {
  /// Backend-issued link_token used to configure Plaid Link (country: CA).
  OmniResult<String> createLinkToken();

  /// Opens Plaid Link and, on success, returns the short-lived public_token.
  OmniResult<String> openLink(String linkToken);

  /// Exchanges the public_token for a persisted connection (the access_token
  /// stays server-side); resolves to the linked account metadata.
  OmniResult<LinkedBankAccount> exchangePublicToken(String publicToken);
}
