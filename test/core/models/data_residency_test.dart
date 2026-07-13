import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/data_region.dart';
import 'package:growth_pilot_ai/core/models/data_residency.dart';

void main() {
  group('DataRegion', () {
    test('exposes a human label and Canadian flag', () {
      expect(DataRegion.caCentral.label, 'AWS Canada (Central)');
      expect(DataRegion.caCentral.isCanadian, isTrue);
      expect(DataRegion.usEast.isCanadian, isFalse);
    });
  });

  group('DataResidency', () {
    test('defaults to Canada Central and is PIPA compliant', () {
      final residency = DataResidency.fromEnvironment();
      expect(residency.region, DataRegion.caCentral);
      expect(residency.isPipaCompliant, isTrue);
    });

    test('a non-Canadian region is not PIPA compliant', () {
      const residency = DataResidency(region: DataRegion.usEast);
      expect(residency.isPipaCompliant, isFalse);
    });

    test('disabling encryption at rest breaks compliance', () {
      const residency =
          DataResidency(region: DataRegion.caCentral, encryptedAtRest: false);
      expect(residency.isPipaCompliant, isFalse);
    });

    test('a TLS version below 1.2 breaks compliance', () {
      const residency =
          DataResidency(region: DataRegion.caCentral, minTlsVersion: 1.0);
      expect(residency.isPipaCompliant, isFalse);
    });
  });
}
