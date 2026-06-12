import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';

abstract class ITransactionController extends GetxController {
  RxList<TransactionEntity> get filteredTransactions;
  RxBool get isLoading;
  Future<void> fetchTransactions();
  void searchTransactions(String query);
}
