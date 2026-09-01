import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The visitor-count field plus date picker for a new logged day
/// (Issue #387).
class VisitorCountFields extends StatelessWidget {
  final TextEditingController countController;
  final DateTime? date;
  final VoidCallback onPickDate;

  const VisitorCountFields({
    super.key,
    required this.countController,
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
        ShadInput(
            placeholder: const Text('Visitor count'),
            controller: countController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadButton.outline(
          onPressed: onPickDate,
          child: Text(_label(date, 'Pick date'), style: TextStyle(color: fg)),
        ),
      ],
    );
  }
}
