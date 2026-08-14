import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';
import 'package:growth_pilot_ai/core/enum/integration_status.dart';
import 'package:growth_pilot_ai/core/models/accounting_integration.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Applies a token-refresh result to an [AccountingIntegration], per Issue
/// #56's error-handling rule: a rejected refresh (e.g. "invalid_grant") marks
/// the integration disconnected so the UI can prompt "Fix Connection". Only
/// the provider label and failure reason code are ever logged — never a token.
class TokenRefreshOutcome {
  static AccountingIntegration onSuccess(AccountingIntegration integration) {
    OmniLogger.info('${integration.provider.label} token refresh succeeded');
    return integration.copyWith(status: IntegrationStatus.connected);
  }

  static AccountingIntegration onFailure(
    AccountingIntegration integration, {
    required String reason,
  }) {
    OmniLogger.warning(
      '${integration.provider.label} token refresh failed ($reason) — '
      'marking disconnected, re-authentication required',
    );
    return integration.copyWith(status: IntegrationStatus.disconnected);
  }
}
