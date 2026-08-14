import 'dart:math';

import 'package:growth_pilot_ai/business/add_laplace_noise.dart';
import 'package:growth_pilot_ai/business/is_dataset_too_small_for_dp.dart';
import 'package:growth_pilot_ai/business/is_privacy_budget_exhausted.dart';
import 'package:growth_pilot_ai/business/record_epsilon_consumption.dart';
import 'package:growth_pilot_ai/core/data/entities/epsilon_consumption_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/epsilon_consumption_repository.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// The DP query gate (Issue #81), mirroring the issue's own
/// `getIndustryAverage` example: refuses queries on datasets smaller
/// than 5 records, refuses once a user/session's Privacy Budget is
/// exhausted (checked *before* charging, so a blocked query never
/// consumes budget), and otherwise noises the result and records the
/// spend.
class QueryAggregateWithDifferentialPrivacy {
  static OmniResult<int> call(
    EpsilonConsumptionRepository repo,
    String userId,
    num rawValue,
    int datasetSize,
    Random random, {
    double epsilon = 0.1,
    double maxBudget = 10,
    DateTime? now,
  }) async {
    if (IsDatasetTooSmallForDp.call(datasetSize)) {
      return OmniResponse.error('Dataset too small to query privately.', statusCode: 403);
    }

    final ledger = repo.getForUser(userId);
    final priorSpend = ledger?.totalEpsilonSpent ?? 0;
    final newSpend = RecordEpsilonConsumption.call(priorSpend, epsilon);
    if (IsPrivacyBudgetExhausted.call(newSpend, maxBudget)) {
      return OmniResponse.error('Privacy budget exhausted for this session.', statusCode: 429);
    }

    final noisyValue = AddLaplaceNoise.call(rawValue, random, epsilon: epsilon);
    repo.upsert(EpsilonConsumptionEntity(
      id: ledger?.id ?? 0,
      userId: userId,
      totalEpsilonSpent: newSpend,
      updatedAt: now ?? DateTime.now(),
    ));
    return OmniResponse.success(noisyValue);
  }
}
