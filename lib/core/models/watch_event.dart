import 'package:flutter/foundation.dart';

/// Records that a user opened a video (Issue #163's "Continue Watching")
/// — this offline-first client has no embedded player to report a real
/// mid-playback position from, so recency of [openedAt] stands in for
/// progress.
@immutable
class WatchEvent {
  final String videoId;
  final DateTime openedAt;

  const WatchEvent({required this.videoId, required this.openedAt});
}
