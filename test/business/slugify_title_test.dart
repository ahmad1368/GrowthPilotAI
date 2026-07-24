import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/slugify_title.dart';

void main() {
  test('lowercases and joins words with underscores', () {
    expect(SlugifyTitle.call('Business Compass'), 'business_compass');
  });

  test('collapses non-alphanumeric runs into a single underscore', () {
    expect(SlugifyTitle.call('Q3 Report: Surrey / BC!!'), 'q3_report_surrey_bc_');
  });

  test('leaves an already-safe string unchanged', () {
    expect(SlugifyTitle.call('report'), 'report');
  });
}
