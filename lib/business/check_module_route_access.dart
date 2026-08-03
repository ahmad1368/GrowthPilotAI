import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';

/// Whether a route is allowed to be entered given the logged module
/// toggles (Issue #339, acceptance criterion 3) — a route with no
/// matching toggle is allowed by default; only an explicit `isEnabled:
/// false` blocks it.
class CheckModuleRouteAccess {
  static bool call(List<FeatureModuleToggleEntity> toggles, String? routeName) {
    if (routeName == null) return true;
    final matches = toggles.where((t) => t.routeName == routeName);
    if (matches.isEmpty) return true;
    final latest = matches.reduce((a, b) => b.updatedAt.isAfter(a.updatedAt) ? b : a);
    return latest.isEnabled;
  }
}
