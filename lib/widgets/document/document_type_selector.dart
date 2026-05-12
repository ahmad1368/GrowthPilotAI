import 'package:flutter/material.dart';
import '../adaptive_text.dart';

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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // استفاده از AdaptiveText طبق استاندارد پروژه
        AdaptiveText(
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
            Icon(Icons.category_outlined, color: Colors.cyanAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButton<String>(
                value:
                    availableTypes.contains(initialType) ? initialType : null,
                hint: AdaptiveText(initialType),
                isExpanded: true,
                underline: Container(height: 1, color: Colors.white10),
                dropdownColor: isDarkMode ? Colors.grey[900] : Colors.white,
                items: availableTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: AdaptiveText(type),
                        ))
                    .toList(),
                onChanged: (val) => onTypeSelected(val!),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: Colors.cyanAccent),
              onPressed: onAddNew,
              tooltip: "افزودن نوع سند جدید",
            )
          ],
        ),
      ],
    );
  }
}
