import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/accounting_provider.dart';

/// A prepared OAuth authorization request: the provider login URL to open plus
/// the CSRF [state] the caller must retain to verify the callback.
@immutable
class AuthorizationRequest {
  final AccountingProvider provider;
  final String authorizationUrl;
  final String state;

  const AuthorizationRequest({
    required this.provider,
    required this.authorizationUrl,
    required this.state,
  });
}
