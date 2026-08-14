import 'package:flutter/foundation.dart';

/// A tenant in the multi-tenant model. Financial data links to a [id]
/// (BusinessID) rather than a user, so one identity can run several distinct
/// businesses. [craBusinessNumber] is the 9-digit Canadian CRA BN.
@immutable
class Business {
  final String id;
  final String legalName;
  final String? operatingName;
  final String craBusinessNumber;
  final String? sector;
  final String currencyPreference;

  const Business({
    required this.id,
    required this.legalName,
    required this.craBusinessNumber,
    this.operatingName,
    this.sector,
    this.currencyPreference = 'CAD',
  });

  String get displayName => operatingName ?? legalName;
}
