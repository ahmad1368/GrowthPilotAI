import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_error_log_csv.dart';

void main() {
  test('renders a header row plus one line per error', () {
    final csv = BuildErrorLogCsv.call([(row: 5, error: 'Missing name.')]);
    expect(csv, 'row,error\n5,"Missing name."\n');
  });

  test('escapes embedded quotes in the error message', () {
    final csv = BuildErrorLogCsv.call([(row: 2, error: 'Invalid "price" format.')]);
    expect(csv, contains('""price""'));
  });
}
