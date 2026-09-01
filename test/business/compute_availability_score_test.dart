import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_availability_score.dart';
import 'package:growth_pilot_ai/core/enum/catalog_availability.dart';

void main() {
  test('scores 1.0 when available', () {
    expect(ComputeAvailabilityScore.call(CatalogAvailability.available), 1.0);
  });

  test('scores 0.0 for every other state', () {
    for (final state in [
      CatalogAvailability.contract,
      CatalogAvailability.soldOut,
      CatalogAvailability.comingSoon,
      CatalogAvailability.inactive,
    ]) {
      expect(ComputeAvailabilityScore.call(state), 0.0);
    }
  });
}
