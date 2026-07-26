import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_inventory_expiry_label.dart';

void main() {
  final now = DateTime(2026, 6, 15);

  test('a future expiry date reads "Expires in Xd"', () {
    final label = BuildInventoryExpiryLabel.call(now.add(const Duration(days: 3)), now);
    expect(label, 'Expires in 3d');
  });

  test('a past expiry date reads "Xd expired"', () {
    final label = BuildInventoryExpiryLabel.call(now.subtract(const Duration(days: 2)), now);
    expect(label, '2d expired');
  });
}
