import 'package:flutter/foundation.dart';

/// "Project Health Score (A-F)" (Issue #236's "Health Check" Widget).
@immutable
class ProjectHealthGrade {
  final double score;
  final String letter;

  const ProjectHealthGrade({required this.score, required this.letter});
}
