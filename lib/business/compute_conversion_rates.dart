import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/visitor_count_entity.dart';
import 'package:growth_pilot_ai/core/models/conversion_rate.dart';

/// Matches each logged daily visitor count against same-day transactions
/// to derive a conversion% read (Issue #387) — this app has no optical
/// counter/web-analytics telemetry, so visitor counts are logged
/// manually and correlated with existing transaction data instead.
class ComputeConversionRates {
  static List<ConversionRate> call(
    List<VisitorCountEntity> counts,
    List<TransactionEntity> transactions,
  ) {
    final results = counts.map((count) {
      final transactionCount = transactions
          .where((t) => _isSameDay(t.date, count.date))
          .length;
      final conversionPercent = count.visitorCount == 0
          ? 0.0
          : (transactionCount / count.visitorCount) * 100;

      return ConversionRate(
        date: count.date,
        visitorCount: count.visitorCount,
        transactionCount: transactionCount,
        conversionPercent: conversionPercent,
      );
    }).toList();

    results.sort((a, b) => b.conversionPercent.compareTo(a.conversionPercent));
    return results;
  }

  static bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
