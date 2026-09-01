import 'package:objectbox/objectbox.dart';

/// Single-row admin-configured daily transaction volume cap (Issue
/// #344, acceptance criterion 1) for new startup/merchant accounts —
/// mirrors [StoreProfileEntity]'s single-row pattern.
@Entity()
class DailyTransactionCapEntity {
  @Id()
  int id = 0;

  double capAmount;

  DailyTransactionCapEntity({this.id = 0, this.capAmount = 500});
}
