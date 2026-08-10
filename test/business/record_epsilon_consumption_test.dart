import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/record_epsilon_consumption.dart';

void main() {
  test('accumulates epsilon spend across queries', () {
    var total = 0.0;
    total = RecordEpsilonConsumption.call(total, 0.1);
    total = RecordEpsilonConsumption.call(total, 0.1);
    total = RecordEpsilonConsumption.call(total, 0.5);
    expect(total, closeTo(0.7, 1e-9));
  });
}
