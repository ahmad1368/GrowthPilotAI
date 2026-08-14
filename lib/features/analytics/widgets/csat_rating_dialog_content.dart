import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/csat_rating_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/csat_rating_fields.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Stateful form body for [showCsatRatingDialog] (Issue #375): owns the
/// score, note controller, and picked date.
class CsatRatingDialogContent extends StatefulWidget {
  const CsatRatingDialogContent({super.key});

  @override
  State<CsatRatingDialogContent> createState() =>
      _CsatRatingDialogContentState();
}

class _CsatRatingDialogContentState extends State<CsatRatingDialogContent> {
  final _noteController = TextEditingController();
  int _score = 5;
  DateTime? _date;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 3650)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  void _submit() {
    if (_date == null) return;
    final note = _noteController.text.trim();
    Navigator.of(context).pop(CsatRatingEntity(
      score: _score,
      date: _date!,
      note: note.isEmpty ? null : note,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog.alert(
      title: const Text('Log CSAT Rating'),
      description: CsatRatingFields(
        score: _score,
        onScoreChanged: (s) => setState(() => _score = s),
        noteController: _noteController,
        date: _date,
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
