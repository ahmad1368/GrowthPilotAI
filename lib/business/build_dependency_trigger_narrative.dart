import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';
import 'package:growth_pilot_ai/core/enum/merchant_dependency_tier.dart';

/// One-sentence, rule-based summary of a dependency evaluation (Issue
/// #424, acceptance criterion 5) — used both on-screen and as the
/// audit-log justification when a tier transition triggers.
class BuildDependencyTriggerNarrative {
  static String call(MerchantDependencyEvaluationEntity evaluation) {
    final score = evaluation.dependencyScore;
    switch (evaluation.tier) {
      case MerchantDependencyTier.highDependency:
        return '${evaluation.merchantName} crossed the high-dependency threshold '
            '(score $score/100) — advanced billing tier unlocked.';
      case MerchantDependencyTier.engaged:
        return '${evaluation.merchantName} shows engaged platform usage (score $score/100).';
      case MerchantDependencyTier.standard:
        return '${evaluation.merchantName} is within standard usage patterns (score $score/100).';
    }
  }
}
