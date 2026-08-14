import 'package:flutter/foundation.dart';

/// Risk tier for one compliance item based on days-until-expiry (Issue
/// #392).
enum ComplianceRiskLevel { ok, expiringSoon, expired }

/// One compliance item's computed expiry risk (Issue #392).
@immutable
class ComplianceRiskItem {
  final String name;
  final DateTime expiryDate;
  final int daysUntilExpiry;
  final ComplianceRiskLevel riskLevel;

  const ComplianceRiskItem({
    required this.name,
    required this.expiryDate,
    required this.daysUntilExpiry,
    required this.riskLevel,
  });
}
