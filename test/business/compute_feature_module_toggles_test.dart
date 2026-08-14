import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_feature_module_toggle_narrative.dart';
import 'package:growth_pilot_ai/business/check_module_route_access.dart';
import 'package:growth_pilot_ai/business/compute_feature_module_toggles.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';

FeatureModuleToggleEntity _toggle({
  String moduleName = 'Integrations',
  String routeName = '/settings/integrations',
  bool isEnabled = true,
  DateTime? updatedAt,
}) =>
    FeatureModuleToggleEntity(
      moduleName: moduleName,
      routeName: routeName,
      isEnabled: isEnabled,
      updatedAt: updatedAt ?? DateTime(2024, 3, 1),
    );

void main() {
  group('ComputeFeatureModuleToggles', () {
    test('returns empty list when no modules are logged', () {
      expect(ComputeFeatureModuleToggles.call(const []), isEmpty);
    });

    test('keeps only the most recent state per module', () {
      final results = ComputeFeatureModuleToggles.call([
        _toggle(isEnabled: true, updatedAt: DateTime(2024, 1, 1)),
        _toggle(isEnabled: false, updatedAt: DateTime(2024, 6, 1)),
      ]);

      expect(results, hasLength(1));
      expect(results.single.isEnabled, isFalse);
    });

    test('sorts modules alphabetically by name', () {
      final results = ComputeFeatureModuleToggles.call([
        _toggle(moduleName: 'Zeta', routeName: '/zeta'),
        _toggle(moduleName: 'Alpha', routeName: '/alpha'),
      ]);

      expect(results.first.moduleName, 'Alpha');
      expect(results.last.moduleName, 'Zeta');
    });
  });

  group('CheckModuleRouteAccess', () {
    test('allows a route with no matching toggle', () {
      expect(CheckModuleRouteAccess.call(const [], '/settings'), isTrue);
    });

    test('blocks a route whose latest toggle is disabled', () {
      final toggles = [_toggle(routeName: '/settings/integrations', isEnabled: false)];

      expect(CheckModuleRouteAccess.call(toggles, '/settings/integrations'), isFalse);
    });

    test('uses the most recently updated toggle when duplicates exist', () {
      final toggles = [
        _toggle(routeName: '/settings/integrations', isEnabled: false, updatedAt: DateTime(2024, 1, 1)),
        _toggle(routeName: '/settings/integrations', isEnabled: true, updatedAt: DateTime(2024, 6, 1)),
      ];

      expect(CheckModuleRouteAccess.call(toggles, '/settings/integrations'), isTrue);
    });
  });

  group('BuildFeatureModuleToggleNarrative', () {
    test('falls back when no modules are logged', () {
      expect(BuildFeatureModuleToggleNarrative.call(const []),
          contains('No modules configured'));
    });

    test('reports how many modules are disabled', () {
      final results = ComputeFeatureModuleToggles.call(
          [_toggle(moduleName: 'A', routeName: '/a', isEnabled: false)]);

      expect(BuildFeatureModuleToggleNarrative.call(results),
          contains('1 of 1 module(s) are disabled'));
    });
  });
}
