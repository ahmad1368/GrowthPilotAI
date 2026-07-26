import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_active_suppliers.dart';
import 'package:growth_pilot_ai/core/data/entities/vendor_entity.dart';

void main() {
  test('excludes archived suppliers', () {
    final vendors = [
      VendorEntity(name: 'Active Co', isActive: true),
      VendorEntity(name: 'Archived Co', isActive: false),
    ];

    final results = ComputeActiveSuppliers.call(vendors);

    expect(results.map((v) => v.name), ['Active Co']);
  });

  test('sorts alphabetically by name', () {
    final vendors = [
      VendorEntity(name: 'Zebra Supplies'),
      VendorEntity(name: 'Acme Co'),
      VendorEntity(name: 'Midway Traders'),
    ];

    final results = ComputeActiveSuppliers.call(vendors);

    expect(results.map((v) => v.name), ['Acme Co', 'Midway Traders', 'Zebra Supplies']);
  });

  test('no vendors returns an empty list', () {
    expect(ComputeActiveSuppliers.call([]), isEmpty);
  });
}
