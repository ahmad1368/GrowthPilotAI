import 'package:growth_pilot_ai/core/models/project_health_grade.dart';

/// "An overall 'Project Health Score' (A-F) based on these 4 KPIs"
/// (Issue #236) — equal-weighted average of (low volatility, high
/// engagement, high completeness, low risk), each already `[0, 1]` or
/// `[0, 100]`.
class ComputeProjectHealthGrade {
  static ProjectHealthGrade call({
    required double volatilityRate,
    required double engagementRate,
    required double completenessRate,
    required double riskScore,
  }) {
    final score = ((1 - volatilityRate) * 25) +
        (engagementRate * 25) +
        (completenessRate * 25) +
        ((1 - (riskScore / 100).clamp(0.0, 1.0)) * 25);
    return ProjectHealthGrade(score: score, letter: _letterFor(score));
  }

  static String _letterFor(double score) {
    if (score >= 90) return 'A';
    if (score >= 80) return 'B';
    if (score >= 70) return 'C';
    if (score >= 60) return 'D';
    return 'F';
  }
}
