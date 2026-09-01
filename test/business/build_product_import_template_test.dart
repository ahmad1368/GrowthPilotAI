import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_product_import_template.dart';

void main() {
  test('header row matches the expected import columns', () {
    final template = BuildProductImportTemplate.call();
    expect(template.split('\n').first, 'name,sku,category,industry,price');
  });
}
