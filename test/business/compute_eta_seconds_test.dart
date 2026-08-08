import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_eta_seconds.dart';

void main() {
  test('estimates remaining time from measured throughput', () {
    final eta = ComputeEtaSeconds.call(elapsedSeconds: 2.0, processed: 50, total: 200);
    expect(eta, closeTo(6.0, 0.001));
  });

  test('returns 0 once everything is processed', () {
    expect(ComputeEtaSeconds.call(elapsedSeconds: 2.0, processed: 100, total: 100), 0);
  });

  test('returns 0 before any progress has been made', () {
    expect(ComputeEtaSeconds.call(elapsedSeconds: 0, processed: 0, total: 100), 0);
  });
}
