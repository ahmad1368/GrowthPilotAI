import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/has_enough_storage_for_model.dart';

void main() {
  group('HasEnoughStorageForModel', () {
    test('true when free space meets the 4GB minimum', () {
      expect(HasEnoughStorageForModel.call(HasEnoughStorageForModel.requiredFreeBytes), isTrue);
    });

    test('true when free space exceeds the minimum', () {
      expect(HasEnoughStorageForModel.call(HasEnoughStorageForModel.requiredFreeBytes * 2), isTrue);
    });

    test('false when free space is just under the minimum', () {
      expect(HasEnoughStorageForModel.call(HasEnoughStorageForModel.requiredFreeBytes - 1), isFalse);
    });
  });
}
