import 'package:flutter/foundation.dart';

/// Canadian sales-tax split for a transaction, used for tax filing and Input
/// Tax Credit (ITC) calculations. Amounts are in the transaction currency.
@immutable
class TaxBreakdown {
  final double gst;
  final double pst;
  final double hst;

  const TaxBreakdown({this.gst = 0, this.pst = 0, this.hst = 0});

  double get total => double.parse((gst + pst + hst).toStringAsFixed(2));
}
