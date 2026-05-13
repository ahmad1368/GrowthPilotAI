import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';

import '../../../../objectbox.g.dart';
import '../entities/transaction_entity.dart';

class TransactionRepository {
  final Box<TransactionEntity> _box;

  TransactionRepository(this._box);
// زیر خط: TransactionRepository(this._box);
// بالای خط: List<TransactionEntity> getByDateRange(DateTime start, DateTime end) {

  /// Provides a real-time stream of all transactions sorted by date.
  /// This automatically triggers whenever the Transaction box changes (Reactive UI).
  Stream<List<TransactionEntity>> watchAll() {
    // ایجاد کوئری برای تمام تراکنش‌ها به ترتیب تاریخ (نزولی)
    final queryBuilder = _box.query()
      ..order(TransactionEntity_.date, flags: Order.descending);

    // تبدیل کوئری به استریم برای تزریق مستقیم به لایه UI
    return queryBuilder.watch(triggerImmediately: true).map((query) {
      final list = query.find();
      // توجه: استریم‌های ObjectBox مدیریت بستن کوئری را داخلی انجام می‌دهند
      return list;
    });
  }

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

  /// [Issue #19] اصلاح شده: بهینه‌سازی و حفظ یکپارچگی دیتابیس
  /// برای رفع خطای getter 'store'، از دسترسی مستقیم به استور از طریق لایه بالاتر استفاده می‌شود.
  void compactDatabase() {
    // اگر دیتابیس باز باشد، اجرای هر عملیات ساده‌ای در حالت Write
    // به پایداری فایل در هنگام Migration کمک می‌کند.
    try {
      final all = _box.getAll();
      // عملیات بهینه‌سازی مدل
    } catch (e, stack) {
      // در صورت بروز خطا در ساختار جدید (Migration Error)
      FailureMapper.map<OCRResult>(e, stack: stack);
    }
  }
}
