import 'package:objectbox/objectbox.dart';

/// Single-row admin-configured breach threshold for the price
/// volatility alert system (Issue #340, acceptance criterion 1) —
/// mirrors [StoreProfileEntity]'s single-row pattern. A price swing of
/// at least this percent between two consecutive logged observations
/// of the same product is flagged as an alert.
@Entity()
class PriceAlertThresholdEntity {
  @Id()
  int id = 0;

  double thresholdPercent;

  PriceAlertThresholdEntity({this.id = 0, this.thresholdPercent = 10});
}
