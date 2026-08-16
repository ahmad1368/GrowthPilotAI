import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';
import 'package:growth_pilot_ai/features/academy/widgets/academy_video_card.dart';

/// Horizontal "Continue Watching" shelf (Issue #163) — hidden entirely
/// when [videos] is empty rather than showing an awkward blank section.
class ContinueWatchingRow extends StatelessWidget {
  final List<AcademyVideo> videos;
  final ValueChanged<AcademyVideo> onTap;

  const ContinueWatchingRow({super.key, required this.videos, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (videos.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Continue Watching', style: theme.textTheme.titleMedium),
      const SizedBox(height: 12),
      SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, i) =>
              AcademyVideoCard(video: videos[i], onTap: () => onTap(videos[i])),
        ),
      ),
    ]);
  }
}
