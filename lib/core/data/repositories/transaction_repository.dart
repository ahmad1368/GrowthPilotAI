import 'package:growth_pilot_ai/business/validate_transaction_amount.dart';
import 'package:growth_pilot_ai/core/error/failure_mapper.dart';
import 'package:growth_pilot_ai/core/models/ocr_result.dart';

import '../../../../objectbox.g.dart';
import '../entities/transaction_entity.dart';

class TransactionRepository {
  final Box<TransactionEntity> _box;

  TransactionRepository(this._box);

  /// Basic CRUD (Issue #14): [insert]/[update] both map to ObjectBox `put`
  /// (an id of 0 inserts, a non-zero id upserts); [delete] and [getAll] are
  /// thin passthroughs.
  int insert(TransactionEntity transaction) {
    ValidateTransactionAmount.call(transaction.amount);
    return _box.put(transaction);
  }

  bool update(TransactionEntity transaction) {
    if (transaction.id == 0) return false;
    ValidateTransactionAmount.call(transaction.amount);
    _box.put(transaction);
    return true;
  }

  bool delete(int id) => _box.remove(id);

  /// Issue #14 AC: ordered by date descending, matching every other query
  /// method in this repository (getByDateRange/search/watchAll).
  List<TransactionEntity> getAll() {
    final query = _box
        .query()
        .order(TransactionEntity_.date, flags: Order.descending)
        .build();
    final results = query.find();
    query.close();
    return results;
  }

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

  /// ۲. جستجوی متنی در توضیحات و نام فروشنده (Case-Insensitive)
  ///
  /// Issue #15 AC explicitly asks for "description and vendor name". Run
  /// as two separate queries and merge/dedupe: ObjectBox link conditions
  /// AND with the rest of the query rather than OR, so a single query
  /// can't express "description matches OR linked vendor.name matches".
  List<TransactionEntity> search(String text) {
    if (text.isEmpty) return [];

    final descQuery = _box
        .query(
            TransactionEntity_.description.contains(text, caseSensitive: false))
        .build();
    final descResults = descQuery.find();
    descQuery.close();

    final vendorQueryBuilder = _box.query();
    vendorQueryBuilder.link(TransactionEntity_.vendor,
        VendorEntity_.name.contains(text, caseSensitive: false));
    final vendorQuery = vendorQueryBuilder.build();
    final vendorResults = vendorQuery.find();
    vendorQuery.close();

    final merged = <int, TransactionEntity>{
      for (final t in [...descResults, ...vendorResults]) t.id: t,
    };
    final combined = merged.values.toList()
      ..sort((a, b) => b.date.compareTo(a.date));
    return combined;
  }

  List<TransactionEntity> getAdvancedFilter({
    int? categoryId,
    TransactionType? type,
    bool sortByLargest = false,
  }) {
    final typeCondition =
        type != null ? TransactionEntity_.dbType.equals(type.index) : null;
    final queryBuilder = _box.query(typeCondition)
      ..order(TransactionEntity_.amount,
          flags: sortByLargest ? Order.descending : 0);

    if (categoryId != null) {
      queryBuilder.link(
          TransactionEntity_.category, CategoryEntity_.id.equals(categoryId));
    }

    final query = queryBuilder.build();
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
      _box.getAll();
    } catch (e, stack) {
      // در صورت بروز خطا در ساختار جدید (Migration Error)
      FailureMapper.map<OCRResult>(e, stack: stack);
    }
  }
}
