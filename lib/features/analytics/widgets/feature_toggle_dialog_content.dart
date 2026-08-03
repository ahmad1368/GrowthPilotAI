import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_module_toggle_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/feature_toggle_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showFeatureToggleDialog] (Issue #339): when
/// [existing] is provided the fields are pre-filled and its `id` is
/// preserved so saving updates the same module toggle in place.
class FeatureToggleDialogContent extends StatefulWidget {
  final FeatureModuleToggleEntity? existing;

  const FeatureToggleDialogContent({super.key, this.existing});

  @override
  State<FeatureToggleDialogContent> createState() =>
      _FeatureToggleDialogContentState();
}

class _FeatureToggleDialogContentState
    extends State<FeatureToggleDialogContent> {
  late final _moduleNameController =
      TextEditingController(text: widget.existing?.moduleName);
  late final _routeNameController =
      TextEditingController(text: widget.existing?.routeName);
  late bool _isEnabled = widget.existing?.isEnabled ?? true;

  void _submit() {
    if (_moduleNameController.text.trim().isEmpty ||
        _routeNameController.text.trim().isEmpty) {
      return;
    }
    Navigator.of(context).pop(FeatureModuleToggleEntity(
      id: widget.existing?.id ?? 0,
      moduleName: _moduleNameController.text.trim(),
      routeName: _routeNameController.text.trim(),
      isEnabled: _isEnabled,
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: Text(widget.existing == null ? 'Add Module' : 'Edit Module'),
      description: FeatureToggleFields(
        moduleNameController: _moduleNameController,
        routeNameController: _routeNameController,
        isEnabled: _isEnabled,
        onEnabledChanged: (v) => setState(() => _isEnabled = v),
      ),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ShadButton(onPressed: _submit, child: const Text('Save')),
      ],
    );
  }
}
