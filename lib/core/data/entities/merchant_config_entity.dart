import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/commission_type.dart';

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

  /// Fixed-amount commission, used when [commissionType] is
  /// [CommissionType.fixedAmount] instead of a percentage (Issue #348,
  /// acceptance criterion 1).
  double commissionFixedAmount;

  int dbCommissionType; // CommissionType index

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
    this.commissionFixedAmount = 0,
    this.dbCommissionType = 0, // CommissionType.percentage
    required this.transactionCapAmount,
    this.notes = '',
    required this.updatedAt,
  });

  CommissionType get commissionType => CommissionType.values[dbCommissionType];
  set commissionType(CommissionType value) => dbCommissionType = value.index;
}
