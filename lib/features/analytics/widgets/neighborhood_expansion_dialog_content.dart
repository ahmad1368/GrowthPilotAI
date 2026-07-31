import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/neighborhood_expansion_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/neighborhood_expansion_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showNeighborhoodExpansionDialog] (Issue #372):
/// owns the text controllers and picked evaluated date.
class NeighborhoodExpansionDialogContent extends StatefulWidget {
  const NeighborhoodExpansionDialogContent({super.key});

  @override
  State<NeighborhoodExpansionDialogContent> createState() =>
      _NeighborhoodExpansionDialogContentState();
}

class _NeighborhoodExpansionDialogContentState
    extends State<NeighborhoodExpansionDialogContent> {
  final _neighborhoodController = TextEditingController();
  final _demandGapController = TextEditingController();
  final _competitorCountController = TextEditingController();
  final _costController = TextEditingController();
  DateTime? _evaluatedAt;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _evaluatedAt ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _evaluatedAt = picked);
  }

  void _submit() {
    final demandGap = double.tryParse(_demandGapController.text);
    final competitorCount = int.tryParse(_competitorCountController.text);
    final cost = double.tryParse(_costController.text);
    if (_neighborhoodController.text.trim().isEmpty ||
        demandGap == null ||
        demandGap < 0 ||
        competitorCount == null ||
        competitorCount < 0 ||
        cost == null ||
        cost < 0 ||
        _evaluatedAt == null) {
      return;
    }
    Navigator.of(context).pop(NeighborhoodExpansionEntity(
      neighborhoodName: _neighborhoodController.text.trim(),
      estimatedDemandGap: demandGap,
      competitorCount: competitorCount,
      estimatedExpansionCost: cost,
      evaluatedAt: _evaluatedAt!,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log Neighborhood Evaluation'),
      description: NeighborhoodExpansionFields(
        neighborhoodController: _neighborhoodController,
        demandGapController: _demandGapController,
        competitorCountController: _competitorCountController,
        costController: _costController,
        evaluatedAt: _evaluatedAt,
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
