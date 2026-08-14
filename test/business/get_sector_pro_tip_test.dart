import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/get_sector_pro_tip.dart';

void main() {
  group('GetSectorProTip', () {
    test('returns a sector-specific tip for a known sector', () {
      expect(GetSectorProTip.call('ELECTRONICS'), contains('battery'));
    });

    test('falls back to DEFAULT for an unrecognized sector', () {
      expect(GetSectorProTip.call('NOT_A_REAL_SECTOR'), GetSectorProTip.call('DEFAULT'));
    });

    test('every sector in the profile map has a distinct tip', () {
      const sectors = ['AUTOMOTIVE', 'ELECTRONICS', 'HOME_GOODS', 'SERVICES', 'DEFAULT'];
      final tips = sectors.map(GetSectorProTip.call).toSet();
      expect(tips.length, sectors.length);
    });
  });
}
