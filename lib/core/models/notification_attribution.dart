import 'package:flutter/foundation.dart';

/// The "last tapped notification" session (Issue #161's "Session
/// Persistence... for the next 24 hours") — Last-Click attribution: a
/// conversion recorded while this is still valid gets credited to
/// [alertId]/[category], per the issue's "use one attribution model
/// consistently" compliance note.
@immutable
class NotificationAttribution {
  final int alertId;
  final String category;
  final DateTime attributedAt;

  const NotificationAttribution({
    required this.alertId,
    required this.category,
    required this.attributedAt,
  });
}
