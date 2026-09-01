import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_project_health_grade.dart';

void main() {
  group('ComputeProjectHealthGrade', () {
    test('grades a perfect project as A with score 100', () {
      final grade = ComputeProjectHealthGrade.call(
        volatilityRate: 0,
        engagementRate: 1,
        completenessRate: 1,
        riskScore: 0,
      );

      expect(grade.score, 100);
      expect(grade.letter, 'A');
    });

    test('grades a struggling project as F', () {
      final grade = ComputeProjectHealthGrade.call(
        volatilityRate: 1,
        engagementRate: 0,
        completenessRate: 0,
        riskScore: 100,
      );

      expect(grade.score, 0);
      expect(grade.letter, 'F');
    });
  });
}
