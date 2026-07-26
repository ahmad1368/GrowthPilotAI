import 'package:objectbox/objectbox.dart';
import 'transaction_entity.dart';

@Entity()
class VendorEntity {
  @Id()
  int id = 0;

  @Index()
  String name; // مثل: BC Hydro

  String? taxId; // شماره اقتصادی/HST برای انطباق با قوانین مالیاتی کانادا

  /// Supplier directory fields (Issue #442).
  String contactInfo;
  String paymentTerms;
  int typicalLeadTimeDays;
  bool isActive;

  @Backlink('vendor')
  final transactions = ToMany<TransactionEntity>();

  VendorEntity({
    this.id = 0,
    required this.name,
    this.taxId,
    this.contactInfo = '',
    this.paymentTerms = '',
    this.typicalLeadTimeDays = 0,
    this.isActive = true,
  });
}
