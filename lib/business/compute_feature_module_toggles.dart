import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';

/// Derives each module's current enable/disable state from its most
/// recently saved toggle (Issue #339) — a module may have been saved
/// more than once as its state changed over time, so only the latest
/// per [FeatureModuleToggleEntity.moduleName] is kept, mirroring
/// [ComputeServiceRestrictionStatuses]'s dedupe pattern.
class ComputeFeatureModuleToggles {
  static List<FeatureModuleToggleEntity> call(
      List<FeatureModuleToggleEntity> toggles) {
    final latestByModule = <String, FeatureModuleToggleEntity>{};
    for (final t in toggles) {
      final existing = latestByModule[t.moduleName];
      if (existing == null || t.updatedAt.isAfter(existing.updatedAt)) {
        latestByModule[t.moduleName] = t;
      }
    }

    final results = latestByModule.values.toList();
    results.sort((a, b) => a.moduleName.compareTo(b.moduleName));
    return results;
  }
}
