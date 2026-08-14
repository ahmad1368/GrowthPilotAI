import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_duplicate_sku.dart';

void main() {
  test('flags a SKU already in the existing set', () {
    expect(DetectDuplicateSku.call('C-1', {'C-1', 'C-2'}), isTrue);
  });

  test('does not flag a new SKU', () {
    expect(DetectDuplicateSku.call('C-3', {'C-1', 'C-2'}), isFalse);
  });
}
