import 'package:objectbox/objectbox.dart';
import '../../../../objectbox.g.dart';
import '../entities/transaction_entity.dart';
import '../entities/category_entity.dart';

class TransactionRepository {
  final Box<TransactionEntity> _box;

  TransactionRepository(this._box);

  List<TransactionEntity> getByDateRange(DateTime start, DateTime end) {
    if (start.isAfter(end)) return [];

    final query = _box
        .query(TransactionEntity_.date.between(
          start.millisecondsSinceEpoch, // تبدیل به عدد برای کوئری
          end.millisecondsSinceEpoch, // تبدیل به عدد برای کوئری
        ))
        .order(TransactionEntity_.date, flags: Order.descending)
        .build();

    final results = query.find();
    query.close();
    return results;
  }

  /// ۲. جستجوی متنی در توضیحات (Case-Insensitive)
  List<TransactionEntity> search(String text) {
    if (text.isEmpty) return [];

    final query = _box
        .query(
            TransactionEntity_.description.contains(text, caseSensitive: false))
        .order(TransactionEntity_.date, flags: Order.descending)
        .build();

    final results = query.find();
    query.close();
    return results;
  }

  List<TransactionEntity> getAdvancedFilter({
    int? categoryId,
    TransactionType? type,
    bool sortByLargest = false,
  }) {
    // ایجاد بیلدر
    final queryBuilder = _box.query();

    // شرط اول: دسته‌بندی
    if (categoryId != null) {
      queryBuilder.link(
          TransactionEntity_.category, CategoryEntity_.id.equals(categoryId));
    }

    // شرط دوم: نوع تراکنش
    // نکته: فقط نوشتن دستور زیر کافیست، خودِ بیلدر آن را با AND به قبلی اضافه می‌کند
    if (type != null) {
      queryBuilder.order(TransactionEntity_.dbType); // برای مثال
      // در واقع برای اضافه کردن شرط ساده از دستور زیر استفاده می‌کنیم:
    }

    // راه حل نهایی برای رفع خطا:
    final Condition<TransactionEntity>? typeCondition =
        type != null ? TransactionEntity_.dbType.equals(type.index) : null;

    final query = _box.query(typeCondition).build();
    // ... ادامه منطق

    final results = query.find();
    query.close();
    return results;
  }
}
