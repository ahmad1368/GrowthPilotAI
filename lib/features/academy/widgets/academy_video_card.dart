import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/format_video_duration.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';

/// One video's thumbnail/title/duration (Issue #163) — flat, no
/// Glassmorphism (this app's architecture forbids BackdropFilter despite
/// the issue's literal ask).
class AcademyVideoCard extends StatelessWidget {
  final AcademyVideo video;
  final VoidCallback onTap;
  final double width;

  const AcademyVideoCard({super.key, required this.video, required this.onTap, this.width = 200});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
                child: Image.network(video.thumbnailUrl, fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        Icon(Icons.play_circle_outline_rounded, color: theme.colorScheme.onSurface)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(video.title,
              maxLines: 2, overflow: TextOverflow.ellipsis, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 2),
          Text(FormatVideoDuration.call(video.duration),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurface.withValues(alpha: 0.6))),
        ]),
      ),
    );
  }
}
