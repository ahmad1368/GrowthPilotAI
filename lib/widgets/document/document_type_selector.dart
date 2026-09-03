import 'package:flutter/material.dart';

/// Flat document-type selector — replaces the former AdaptiveText usage
/// with plain Text; the dropdown underline now follows [Theme.of(context)]
/// instead of a dark-only hardcoded white.
class DocumentTypeSelector extends StatelessWidget {
  final String initialType;
  final List<String> availableTypes;
  final Function(String) onTypeSelected;
  final VoidCallback onAddNew;

  const DocumentTypeSelector({
    super.key,
    required this.initialType,
    required this.availableTypes,
    required this.onTypeSelected,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;
    final onSurface = theme.colorScheme.onSurface;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "نوع سند شناسایی شده:",
          style: TextStyle(
            color: iconColor.withValues(alpha: 0.6), // استفاده از withValues
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // اصلاح نام آیکون به حروف کوچک
            const Icon(Icons.category_outlined, color: Colors.cyanAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<String>(
                value:
                    availableTypes.contains(initialType) ? initialType : null,
                hint: Text(initialType),
                isExpanded: true,
                underline: Container(
                    height: 1, color: onSurface.withValues(alpha: 0.1)),
                dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
                items: availableTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (val) => onTypeSelected(val!),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline, color: Colors.cyanAccent),
              onPressed: onAddNew,
              tooltip: "افزودن نوع سند جدید",
            )
          ],
        ),
      ],
    );
  }
}
