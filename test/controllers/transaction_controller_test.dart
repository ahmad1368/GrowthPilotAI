import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/transaction_controller.dart';

void main() {
  group('TransactionController Unit Tests', () {
    test('Initial states should be empty and false', () {
      final controller = TransactionController();
      expect(controller.isLoading.value, false);
      expect(controller.filteredTransactions.isEmpty, true);
    });
  });
}
