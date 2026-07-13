import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/connection_policy.dart';

void main() {
  group('ConnectionPolicy', () {
    test('has fail-fast, pooled defaults matching the backend options', () {
      const policy = ConnectionPolicy();
      expect(policy.connectTimeout, const Duration(seconds: 5));
      expect(policy.receiveTimeout, const Duration(seconds: 45));
      expect(policy.maxConcurrent, 10);
      expect(policy.retryWrites, isTrue);
      expect(policy.failsFast, isTrue);
    });

    test('a long connect timeout is not fail-fast', () {
      const policy = ConnectionPolicy(connectTimeout: Duration(seconds: 12));
      expect(policy.failsFast, isFalse);
    });

    test('fromEnvironment falls back to safe defaults', () {
      final policy = ConnectionPolicy.fromEnvironment();
      expect(policy.connectTimeout, const Duration(milliseconds: 5000));
      expect(policy.maxConcurrent, 10);
      expect(policy.failsFast, isTrue);
    });
  });
}
