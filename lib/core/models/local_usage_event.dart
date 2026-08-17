import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/usage_event_type.dart';

/// One in-app usage event (Issue #539) — [label] is a short first-party
/// descriptor (e.g. a screen name or search term the user typed inside
/// this app), never data pulled from another app, site, contacts, GPS,
/// or a microphone.
@immutable
class LocalUsageEvent {
  final UsageEventType type;
  final String label;
  final DateTime occurredAt;

  const LocalUsageEvent({required this.type, required this.label, required this.occurredAt});
}
