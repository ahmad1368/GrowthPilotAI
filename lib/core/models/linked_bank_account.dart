import 'package:flutter/foundation.dart';

/// A successfully linked bank connection (the client-visible result of the
/// Plaid flow). Holds only non-sensitive metadata — never the access token,
/// which lives server-side. [mask] is the last digits Plaid exposes.
@immutable
class LinkedBankAccount {
  final String itemId;
  final String institutionName;
  final String mask;

  const LinkedBankAccount({
    required this.itemId,
    required this.institutionName,
    required this.mask,
  });

  String get maskedLabel => '$institutionName ••$mask';
}
