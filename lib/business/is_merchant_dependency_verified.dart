import 'package:growth_pilot_ai/core/data/entities/merchant_dependency_evaluation_entity.dart';

/// Whether a merchant has been through the dependency-detection
/// engine at least once (Issue #425 depends on #424's verification
/// step) — gates access to the preferential graduated commission
/// schedule; unverified merchants stay on the platform's standard
/// flat rate.
class IsMerchantDependencyVerified {
  static bool call(String merchantName, List<MerchantDependencyEvaluationEntity> evaluations) =>
      evaluations.any((e) => e.merchantName == merchantName);
}
