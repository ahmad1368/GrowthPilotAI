import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';

/// Category filter (Issue #163 AC: "Search & Filter") — a null
/// [category] means "All".
class FilterVideosByCategory {
  static List<AcademyVideo> call(List<AcademyVideo> videos, AcademyVideoCategory? category) {
    if (category == null) return videos;
    return videos.where((v) => v.category == category).toList();
  }
}
