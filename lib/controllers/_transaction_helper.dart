import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import '../core/data/entities/transaction_entity.dart';

class TransactionHelper {
  static void seedTestData(Box<TransactionEntity> box) {
    if (!box.isEmpty()) return;

    final now = DateTime.now();
    final testItems = [
      TransactionEntity(
          description: "خرید اشتراک Azure (تستی)",
          amount: 45.0,
          date: now,
          dbType: 0),
      TransactionEntity(
          description: "درآمد پروژه Flutter (تستی)",
          amount: 1200.0,
          date: now.subtract(const Duration(days: 5)),
          dbType: 1),
    ];

    box.putMany(testItems);
  }
}
