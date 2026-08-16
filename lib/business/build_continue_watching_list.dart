import 'package:growth_pilot_ai/core/models/academy_video.dart';
import 'package:growth_pilot_ai/core/models/watch_event.dart';

/// Videos the user has started, most-recently-opened first (Issue #163's
/// "Continue Watching"). Unknown video IDs (deleted/renamed catalog
/// entries) are silently dropped rather than crashing.
class BuildContinueWatchingList {
  static List<AcademyVideo> call(List<AcademyVideo> videos, List<WatchEvent> events) {
    final sorted = [...events]..sort((a, b) => b.openedAt.compareTo(a.openedAt));
    final result = <AcademyVideo>[];
    for (final event in sorted) {
      for (final video in videos) {
        if (video.id == event.videoId && !result.contains(video)) {
          result.add(video);
          break;
        }
      }
    }
    return result;
  }
}
