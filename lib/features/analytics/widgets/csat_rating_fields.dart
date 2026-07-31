import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The 1-5 score selector, optional note field, and date picker for a new
/// CSAT rating (Issue #375).
class CsatRatingFields extends StatelessWidget {
  final int score;
  final ValueChanged<int> onScoreChanged;
  final TextEditingController noteController;
  final DateTime? date;
  final VoidCallback onPickDate;

  const CsatRatingFields({
    super.key,
    required this.score,
    required this.onScoreChanged,
    required this.noteController,
    required this.date,
    required this.onPickDate,
  });

  String _label(DateTime? d, String placeholder) => d == null
      ? placeholder
      : '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final fg = Theme.of(context).colorScheme.onSurface;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadSelect<int>(
          initialValue: score,
          options: [1, 2, 3, 4, 5]
              .map((s) => ShadOption(value: s, child: Text('$s/5')))
              .toList(),
          selectedOptionBuilder: (context, value) => Text('$value/5'),
          onChanged: (value) {
            if (value != null) onScoreChanged(value);
          },
        ),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Note (optional)'), controller: noteController),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(date, 'Pick date'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
