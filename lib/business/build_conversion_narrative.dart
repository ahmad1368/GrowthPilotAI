import 'package:growth_pilot_ai/core/models/conversion_rate.dart';

/// One-sentence read naming the best and worst logged conversion days
/// (Issue #387).
class BuildConversionNarrative {
  static String call(List<ConversionRate> results) {
    if (results.isEmpty) {
      return 'No visitor counts logged yet — add one to start tracking conversion.';
    }
    if (results.length == 1) {
      final only = results.first;
      return 'Conversion was ${only.conversionPercent.toStringAsFixed(1)}% '
          'on that logged day.';
    }
    final best = results.first;
    final worst = results.last;
    return 'Best conversion day hit ${best.conversionPercent.toStringAsFixed(1)}% — '
        'worst dropped to ${worst.conversionPercent.toStringAsFixed(1)}%.';
  }
}
