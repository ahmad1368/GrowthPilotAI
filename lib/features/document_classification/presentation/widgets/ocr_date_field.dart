import 'package:flutter/material.dart';

/// [Issue #27] Editable date field — the extracted date already reached
/// this screen (Issue #24's DateUtilityParser) but had no UI to show or fix
/// it, so a misread date was silently unfixable before saving.
class OcrDateField extends StatelessWidget {
  final ValueNotifier<DateTime> dateNotifier;

  const OcrDateField({super.key, required this.dateNotifier});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ValueListenableBuilder<DateTime>(
      valueListenable: dateNotifier,
      builder: (context, date, _) {
        return InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            // Future dates fail FinancialParser.validate() too (Issue #24) —
            // the picker enforces the same rule up front.
            final picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (picked != null) dateNotifier.value = picked;
          },
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today_rounded,
                  size: 20, color: Theme.of(context).colorScheme.primary),
              filled: true,
              fillColor: isDark ? Colors.white10 : Colors.white70,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            child: Text(
              '${date.year}-${date.month.toString().padLeft(2, '0')}-'
              '${date.day.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        );
      },
    );
  }
}
