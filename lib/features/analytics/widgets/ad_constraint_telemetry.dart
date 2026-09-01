import 'package:growth_pilot_ai/business/record_promo_click.dart';
import 'package:growth_pilot_ai/business/record_promo_impression.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_constraint_repos.dart';

/// Records simulated view/click telemetry for a constrained campaign
/// (Issue #409, acceptance criterion 4) — split out of
/// [AdConstraintActions] to stay under the file line cap.
class AdConstraintTelemetry {
  final AdConstraintRepos repos;

  AdConstraintTelemetry(this.repos);

  void simulateImpression(int requestId) {
    final updated = RecordPromoImpression.call(
        repos.metrics.forRequest(requestId), requestId, DateTime.now());
    repos.metrics.save(updated);
  }

  void simulateClick(int requestId) {
    final existing = repos.metrics.forRequest(requestId);
    if (existing != null) repos.metrics.save(RecordPromoClick.call(existing));
  }
}
