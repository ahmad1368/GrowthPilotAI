import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_reputation_score.dart';

void main() {
  test('scales a perfect rating to 1.0', () {
    expect(ComputeReputationScore.call(bayesianRating: 5, isKycVerified: false), 1.0);
  });

  test('KYC verification adds a bonus, clamped at 1.0', () {
    expect(ComputeReputationScore.call(bayesianRating: 5, isKycVerified: true), 1.0);
    expect(ComputeReputationScore.call(bayesianRating: 3, isKycVerified: true),
        closeTo(0.75, 0.001));
  });
}
