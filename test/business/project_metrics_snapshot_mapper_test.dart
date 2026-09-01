import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_project_metrics.dart';
import 'package:growth_pilot_ai/core/models/project_metrics_snapshot_mapper.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ProjectMetricsSnapshotMapper', () {
    test('round-trips a computed snapshot through the entity unchanged', () {
      final snapshot = ComputeProjectMetrics.call([
        buildTestRequirement(),
        buildTestRequirement(stakeholder: 'Finance'),
      ]);

      final entity = ProjectMetricsSnapshotMapper.toEntity(snapshot, DateTime(2026, 1, 1));
      final restored = ProjectMetricsSnapshotMapper.fromEntity(entity);

      expect(restored.totalRequirements, snapshot.totalRequirements);
      expect(restored.requirementCounts, snapshot.requirementCounts);
      expect(restored.volatilityRate, snapshot.volatilityRate);
      expect(restored.riskDistribution, snapshot.riskDistribution);
      expect(restored.healthGrade.letter, snapshot.healthGrade.letter);
      expect(restored.healthGrade.score, snapshot.healthGrade.score);
    });
  });
}
