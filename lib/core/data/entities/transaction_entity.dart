import 'package:objectbox/objectbox.dart';
import 'category_entity.dart'; // حتماً اضافه شود
import 'vendor_entity.dart'; // حتماً اضافه شود

// تعریف انواع تراکنش و وضعیت همگام‌سازی
enum TransactionType { expense, income }

enum SyncStatus { synced, pending, error }

@Entity()
class TransactionEntity {
  @Id()
  int id = 0; // آیدی خودکار دیتابیس محلی

  @Unique()
  String? remoteId; // آیدی منحصر به فرد برای هماهنگی با Cloud

  double amount; // مقدار تراکنش

  @Index()
  DateTime date; // ایندکس شده برای جستجوی سریع در داشبورد

  String description;

  // ذخیره به صورت عدد در دیتابیس
  int dbType;
  int dbSyncStatus;

  // --- Relations (Issue #14) ---
  final category = ToOne<CategoryEntity>();
  final vendor = ToOne<VendorEntity>();

  TransactionEntity({
    this.id = 0,
    required this.amount,
    required this.date,
    required this.description,
    this.dbType = 0, // پیش‌فرض: هزینه
    this.dbSyncStatus = 1, // پیش‌فرض: در انتظار (Pending)
  });

  // گترهای کمکی برای خوانایی بیشتر کد در UI
  TransactionType get type => TransactionType.values[dbType];
  SyncStatus get syncStatus => SyncStatus.values[dbSyncStatus];

  // متد کمکی برای تنظیم نوع تراکنش (ملموس‌تر شدن کد)
  set type(TransactionType value) => dbType = value.index;
  set syncStatus(SyncStatus value) => dbSyncStatus = value.index;
}
