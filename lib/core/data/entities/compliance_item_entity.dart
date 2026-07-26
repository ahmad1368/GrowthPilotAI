import 'package:objectbox/objectbox.dart';

/// A tracked license/permit/certification with an expiry date (Issue
/// #392) — the closest local proxy for "compliance risk assessment" this
/// app supports, since there's no municipal registry integration.
@Entity()
class ComplianceItemEntity {
  @Id()
  int id = 0;

  String name;

  @Index()
  DateTime expiryDate;

  ComplianceItemEntity({
    this.id = 0,
    required this.name,
    required this.expiryDate,
  });
}
