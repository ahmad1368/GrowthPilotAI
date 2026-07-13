import 'package:flutter/foundation.dart';

/// A Xero organization the user authorized. Xero can return several per login;
/// the user picks which one to link. Only the id + name are ever stored (PIPA).
@immutable
class XeroTenant {
  final String tenantId;
  final String tenantName;

  const XeroTenant({required this.tenantId, required this.tenantName});
}
