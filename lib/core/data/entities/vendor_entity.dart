import 'package:objectbox/objectbox.dart';
import 'transaction_entity.dart';

@Entity()
class VendorEntity {
  @Id()
  int id = 0;

  @Index()
  String name; // مثل: BC Hydro

  String? taxId; // شماره اقتصادی/HST برای انطباق با قوانین مالیاتی کانادا

  @Backlink('vendor')
  final transactions = ToMany<TransactionEntity>();

  VendorEntity({
    this.id = 0,
    required this.name,
    this.taxId,
  });
}
