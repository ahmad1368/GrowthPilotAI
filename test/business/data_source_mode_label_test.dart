import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/data_source_mode_label.dart';

void main() {
  group('DataSourceModeLabel', () {
    test('labels remote as "Remote Mode" (Issue #264/#265)', () {
      expect(DataSourceModeLabel.call(true), 'Remote Mode');
    });

    test('labels local as "Local Mode"', () {
      expect(DataSourceModeLabel.call(false), 'Local Mode');
    });
  });
}
