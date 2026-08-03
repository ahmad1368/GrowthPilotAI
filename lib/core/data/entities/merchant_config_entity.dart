import 'package:objectbox/objectbox.dart';

/// A single merchant's admin-editable configuration profile (Issue #338)
/// — this app has no backend admin service, so an admin searches and
/// edits each merchant's parameters locally, persisting via ObjectBox
/// `put` (insert when `id == 0`, update in place otherwise) so edits
/// apply immediately without an app restart.
@Entity()
class MerchantConfigEntity {
  @Id()
  int id = 0;

  String businessName;

  String businessId;

  double commissionRatePercent;

  double transactionCapAmount;

  String notes;

  @Index()
  @Property(type: PropertyType.date)
  DateTime updatedAt;

  MerchantConfigEntity({
    this.id = 0,
    required this.businessName,
    required this.businessId,
    required this.commissionRatePercent,
    required this.transactionCapAmount,
    this.notes = '',
    required this.updatedAt,
  });
}
