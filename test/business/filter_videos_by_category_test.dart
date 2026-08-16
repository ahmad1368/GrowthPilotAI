import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_videos_by_category.dart';
import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';

AcademyVideo _video(String id, AcademyVideoCategory category) => AcademyVideo(
      id: id,
      title: id,
      thumbnailUrl: 'https://example.com/$id.jpg',
      videoUrl: 'https://example.com/$id',
      category: category,
      duration: const Duration(minutes: 1),
    );

void main() {
  group('FilterVideosByCategory', () {
    final videos = [
      _video('a', AcademyVideoCategory.tutorial),
      _video('b', AcademyVideoCategory.marketplace),
      _video('c', AcademyVideoCategory.tutorial),
    ];

    test('a null category returns every video ("All")', () {
      expect(FilterVideosByCategory.call(videos, null), videos);
    });

    test('a specific category returns only matching videos', () {
      final result = FilterVideosByCategory.call(videos, AcademyVideoCategory.tutorial);
      expect(result.map((v) => v.id), ['a', 'c']);
    });

    test('a category with no matches returns an empty list', () {
      final result = FilterVideosByCategory.call(videos, AcademyVideoCategory.legal);
      expect(result, isEmpty);
    });
  });
}
