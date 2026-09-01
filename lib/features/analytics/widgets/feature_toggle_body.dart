import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/compute_feature_module_toggles.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/feature_module_toggle_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_view.dart';

/// Owns the module toggle list (Issue #339), saving add/edit changes
/// immediately to ObjectBox so the next navigation or re-login picks up
/// the new state without an app restart.
class FeatureToggleBody extends StatefulWidget {
  final List<FeatureModuleToggleEntity> initialToggles;

  const FeatureToggleBody({super.key, required this.initialToggles});

  @override
  State<FeatureToggleBody> createState() => _FeatureToggleBodyState();
}

class _FeatureToggleBodyState extends State<FeatureToggleBody> {
  late List<FeatureModuleToggleEntity> _toggles = widget.initialToggles;

  Future<void> _save({FeatureModuleToggleEntity? existing}) async {
    final toggle = await showFeatureToggleDialog(context, existing: existing);
    if (toggle == null) return;
    final repo = FeatureModuleToggleRepository(
        Get.find<ObjectBox>().store.box<FeatureModuleToggleEntity>());
    final savedId = repo.save(toggle);
    setState(() {
      _toggles = [
        for (final t in _toggles)
          if (t.id != savedId) t,
        FeatureModuleToggleEntity(
            id: savedId,
            moduleName: toggle.moduleName,
            routeName: toggle.routeName,
            isEnabled: toggle.isEnabled,
            updatedAt: toggle.updatedAt),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ComputeFeatureModuleToggles.call(_toggles);
    return FeatureToggleView(
      results: results,
      onAddModule: () => _save(),
      onEditModule: (toggle) => _save(existing: toggle),
    );
  }
}
