import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/competitor_sighting_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/competitor_proximity_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showCompetitorProximityDialog] (Issue #374):
/// owns the text controllers, selected scale, and picked spotted date.
class CompetitorProximityDialogContent extends StatefulWidget {
  const CompetitorProximityDialogContent({super.key});

  @override
  State<CompetitorProximityDialogContent> createState() =>
      _CompetitorProximityDialogContentState();
}

class _CompetitorProximityDialogContentState
    extends State<CompetitorProximityDialogContent> {
  final _competitorController = TextEditingController();
  final _categoryController = TextEditingController();
  final _distanceController = TextEditingController();
  CompetitorScale _scale = CompetitorScale.small;
  DateTime? _spottedAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _spottedAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _spottedAt = picked);
  }

  void _submit() {
    final distance = double.tryParse(_distanceController.text);
    if (_competitorController.text.trim().isEmpty ||
        _categoryController.text.trim().isEmpty ||
        distance == null ||
        distance < 0 ||
        _spottedAt == null) {
      return;
    }
    Navigator.of(context).pop(CompetitorSightingEntity(
      competitorName: _competitorController.text.trim(),
      category: _categoryController.text.trim(),
      distanceKm: distance,
      spottedAt: _spottedAt!,
    )..scale = _scale);
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Competitor Sighting'),
      description: CompetitorProximityFields(
        competitorController: _competitorController,
        categoryController: _categoryController,
        distanceController: _distanceController,
        scale: _scale,
        onScaleChanged: (s) => setState(() => _scale = s),
        spottedAt: _spottedAt,
        onPickDate: _pickDate,
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
