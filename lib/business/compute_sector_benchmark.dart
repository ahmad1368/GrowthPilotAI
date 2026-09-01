import 'dart:math';

import 'package:growth_pilot_ai/business/add_laplace_noise_to_amount.dart';
import 'package:growth_pilot_ai/business/compute_trimmed_mean.dart';
import 'package:growth_pilot_ai/business/is_dataset_too_small_for_dp.dart';
import 'package:growth_pilot_ai/core/models/anonymous_record.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// The "Aggregator Service" (Issue #82), mirroring the issue's own
/// `getSectorAverages`: guards on minimum sample size, trims outliers
/// per category, then applies DP noise (#91/#81) to each category's
/// benchmark. No Redis cache/cron — this recomputes each call.
class ComputeSectorBenchmark {
  static OmniResponse<Map<String, double>> call(
    List<AnonymousRecord> sectorRecords,
    Random random, {
    double epsilon = 0.1,
    int minimumSampleSize = 10,
  }) {
    if (IsDatasetTooSmallForDp.call(sectorRecords.length, minimumSize: minimumSampleSize)) {
      return OmniResponse.error(
          'Insufficient data for a private benchmark in this sector.',
          statusCode: 403);
    }

    final amountsByCategory = <String, List<double>>{};
    for (final record in sectorRecords) {
      final category = record.category ?? 'uncategorized';
      amountsByCategory.putIfAbsent(category, () => []).add(record.amount);
    }

    final benchmarks = <String, double>{};
    for (final entry in amountsByCategory.entries) {
      final trimmedMean = ComputeTrimmedMean.call(entry.value);
      benchmarks[entry.key] = AddLaplaceNoiseToAmount.call(trimmedMean, random, epsilon: epsilon);
    }
    return OmniResponse.success(benchmarks);
  }
}
