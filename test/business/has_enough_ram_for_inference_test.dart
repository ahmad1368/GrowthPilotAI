import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/has_enough_ram_for_inference.dart';

void main() {
  group('HasEnoughRamForInference', () {
    test('true when free RAM meets the 500MB minimum', () {
      expect(HasEnoughRamForInference.call(HasEnoughRamForInference.requiredFreeMb), isTrue);
    });

    test('true when free RAM exceeds the minimum', () {
      expect(HasEnoughRamForInference.call(2000), isTrue);
    });

    test('false when free RAM is just under the minimum', () {
      expect(HasEnoughRamForInference.call(HasEnoughRamForInference.requiredFreeMb - 1), isFalse);
    });
  });
}
