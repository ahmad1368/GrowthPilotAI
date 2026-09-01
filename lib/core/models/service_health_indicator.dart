import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/service_health_status.dart';

/// One dependency's check result (Issue #166) — the local equivalent of
/// a `@nestjs/terminus` `HealthIndicator`'s `{ [key]: { status, message } }`
/// entry.
@immutable
class ServiceHealthIndicator {
  final String name;
  final ServiceHealthStatus status;
  final String message;

  const ServiceHealthIndicator({
    required this.name,
    required this.status,
    required this.message,
  });
}
