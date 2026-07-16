import 'package:objectbox/objectbox.dart';

/// Persists the user's confirmed Chart-of-Accounts mapping for one
/// transaction (Issue #58 review UI). Written only when the user taps
/// "Confirm" on a [MappingResult] suggestion.
@Entity()
class TransactionMappingStatusEntity {
  @Id()
  int id = 0;

  @Unique()
  int transactionId;

  String confirmedAccountId;
  String confirmedAccountName;
  DateTime confirmedAt;

  TransactionMappingStatusEntity({
    this.id = 0,
    required this.transactionId,
    required this.confirmedAccountId,
    required this.confirmedAccountName,
    required this.confirmedAt,
  });
}
