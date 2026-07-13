import 'package:growth_pilot_ai/core/interfaces/bank_link_service.dart';
import 'package:growth_pilot_ai/core/models/linked_bank_account.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for the Plaid SDK + backend exchange. Emulates the CA
/// bank-link flow so the connect UI can be built and tested without native
/// Plaid or a server. Web-safe. Tokens are never written to the log.
class MockBankLinkService implements BankLinkService {
  @override
  OmniResult<String> createLinkToken() async {
    OmniLogger.info('Created Plaid link token (country: CA)');
    return OmniResponse.success('link-sandbox-ca', message: 'Link token ready');
  }

  @override
  OmniResult<String> openLink(String linkToken) async {
    if (linkToken.isEmpty) {
      return OmniResponse.error('Missing link token', statusCode: 400);
    }
    return OmniResponse.success('public-sandbox-token',
        message: 'Plaid Link completed');
  }

  @override
  OmniResult<LinkedBankAccount> exchangePublicToken(String publicToken) async {
    if (publicToken.isEmpty) {
      return OmniResponse.error('Missing public token', statusCode: 400);
    }
    const account = LinkedBankAccount(
      itemId: 'mock-item-id',
      institutionName: 'RBC Royal Bank',
      mask: '1234',
    );
    // Log only non-sensitive metadata — never the token itself.
    OmniLogger.info('Bank linked: ${account.institutionName}');
    return OmniResponse.success(account, message: 'Bank connected');
  }
}
