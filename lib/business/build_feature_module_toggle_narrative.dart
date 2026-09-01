import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';

/// One-sentence read summarizing how many modules are currently
/// disabled (Issue #339).
class BuildFeatureModuleToggleNarrative {
  static String call(List<FeatureModuleToggleEntity> results) {
    if (results.isEmpty) {
      return 'No modules configured yet — add one to start gating access.';
    }
    final disabled = results.where((r) => !r.isEnabled).length;
    if (disabled == 0) {
      return 'All ${results.length} module(s) are currently enabled.';
    }
    return '$disabled of ${results.length} module(s) are disabled and blocked from routing.';
  }
}
