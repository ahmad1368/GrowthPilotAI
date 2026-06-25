import 'package:objectbox/objectbox.dart';
import 'transaction_entity.dart';

@Entity()
class CategoryEntity {
  @Id()
  int id = 0;

  @Unique()
  String name; // مثل: Marketing

  String icon; // شناسه آیکون برای UI
  int color; // کد رنگ Hex

  @Backlink('category')
  final transactions = ToMany<TransactionEntity>();

  CategoryEntity({
    this.id = 0,
    required this.name,
    this.icon = 'category_rounded',
    this.color = 0xFF2196F3,
  });
}
