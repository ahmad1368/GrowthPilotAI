import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/get_sector_profile.dart';

void main() {
  group('GetSectorProfile', () {
    test('returns the matching profile for a known sector', () {
      final profile = GetSectorProfile.call('AUTOMOTIVE');
      expect(profile.sectorId, 'AUTOMOTIVE');
      expect(profile.radarAxisLabels, contains('Mileage'));
    });

    test('falls back to DEFAULT for an unrecognized sector', () {
      final profile = GetSectorProfile.call('NOT_A_REAL_SECTOR');
      expect(profile.sectorId, 'DEFAULT');
    });

    test('every defined sector has non-empty metrics and radar axes', () {
      for (final sectorId in ['AUTOMOTIVE', 'ELECTRONICS', 'HOME_GOODS', 'SERVICES', 'DEFAULT']) {
        final profile = GetSectorProfile.call(sectorId);
        expect(profile.primaryMetrics, isNotEmpty);
        expect(profile.radarAxisLabels, isNotEmpty);
      }
    });
  });
}
