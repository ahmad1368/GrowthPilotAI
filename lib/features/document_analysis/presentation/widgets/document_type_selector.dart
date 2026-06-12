import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/document_analysis/presentation/widgets/document_type_dropdown.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fgColor = isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "نوع سند شناسایی شده:",
          style: ShadTheme.of(context).textTheme.small.copyWith(
                color: fgColor.withValues(alpha: 0.6),
                fontSize: 11,
              ),
        ),
        const SizedBox(height: 8),
        DocumentTypeDropdown(
          initialType: initialType,
          availableTypes: availableTypes,
          onTypeSelected: onTypeSelected,
          onAddNew: onAddNew,
          isDark: isDark,
        ),
      ],
    );
  }
}
