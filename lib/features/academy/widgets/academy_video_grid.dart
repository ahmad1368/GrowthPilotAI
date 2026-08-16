import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';
import 'package:growth_pilot_ai/features/academy/widgets/academy_video_card.dart';

/// Wrapping grid of every video matching the active filter (Issue #163).
class AcademyVideoGrid extends StatelessWidget {
  final List<AcademyVideo> videos;
  final ValueChanged<AcademyVideo> onTap;

  const AcademyVideoGrid({super.key, required this.videos, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 32),
        child: Center(child: Text('No videos in this category yet')),
      );
    }
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        for (final video in videos) AcademyVideoCard(video: video, onTap: () => onTap(video)),
      ],
    );
  }
}
