import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';

/// One Business Academy video's metadata (Issue #163) — the local
/// stand-in for the issue's NestJS `Video` collection; playback happens
/// externally (the video is hosted on YouTube/Vimeo/Mux, not embedded).
@immutable
class AcademyVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String videoUrl;
  final AcademyVideoCategory category;
  final Duration duration;

  const AcademyVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.category,
    required this.duration,
  });
}
