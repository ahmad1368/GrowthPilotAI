import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/project_health_grade.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "The 'Health Check' Widget: a high-level summary... overall
/// 'Project Health Score' (A-F)" (Issue #236).
class ProjectHealthCheckCard extends StatelessWidget {
  final ProjectHealthGrade grade;

  const ProjectHealthCheckCard({super.key, required this.grade});

  Color _colorFor(String letter) {
    switch (letter) {
      case 'A':
      case 'B':
        return Colors.green;
      case 'C':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final color = _colorFor(grade.letter);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: colors.card, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Text(grade.letter, style: TextStyle(color: color, fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Project Health', style: TextStyle(color: colors.foreground, fontSize: 13)),
              Text('${grade.score.round()} / 100',
                  style: TextStyle(color: colors.mutedForeground, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
