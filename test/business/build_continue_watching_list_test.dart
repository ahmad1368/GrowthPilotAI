import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_continue_watching_list.dart';
import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';
import 'package:growth_pilot_ai/core/models/watch_event.dart';

AcademyVideo _video(String id) => AcademyVideo(
      id: id,
      title: id,
      thumbnailUrl: 'https://example.com/$id.jpg',
      videoUrl: 'https://example.com/$id',
      category: AcademyVideoCategory.tutorial,
      duration: const Duration(minutes: 1),
    );

void main() {
  group('BuildContinueWatchingList', () {
    final videos = [_video('a'), _video('b'), _video('c')];

    test('orders videos most-recently-opened first', () {
      final events = [
        WatchEvent(videoId: 'a', openedAt: DateTime(2026, 1, 1)),
        WatchEvent(videoId: 'b', openedAt: DateTime(2026, 1, 3)),
      ];

      final result = BuildContinueWatchingList.call(videos, events);
      expect(result.map((v) => v.id), ['b', 'a']);
    });

    test('a re-opened video moves to the front instead of appearing twice', () {
      final events = [
        WatchEvent(videoId: 'a', openedAt: DateTime(2026, 1, 1)),
        WatchEvent(videoId: 'b', openedAt: DateTime(2026, 1, 2)),
        WatchEvent(videoId: 'a', openedAt: DateTime(2026, 1, 3)),
      ];

      final result = BuildContinueWatchingList.call(videos, events);
      expect(result.map((v) => v.id), ['a', 'b']);
    });

    test('an event for a video no longer in the catalog is silently dropped', () {
      final events = [WatchEvent(videoId: 'deleted-video', openedAt: DateTime(2026, 1, 1))];
      expect(BuildContinueWatchingList.call(videos, events), isEmpty);
    });
  });
}
