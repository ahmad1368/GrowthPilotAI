import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentTypeDropdown extends StatelessWidget {
  final String initialType;
  final List<String> availableTypes;
  final Function(String) onTypeSelected;
  final VoidCallback onAddNew;
  final bool isDark;

  const DocumentTypeDropdown({
    super.key,
    required this.initialType,
    required this.availableTypes,
    required this.onTypeSelected,
    required this.onAddNew,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor =
        isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Row(
      children: [
        Icon(Icons.category_outlined, color: activeColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: ShadSelect<String>(
            initialValue:
                availableTypes.contains(initialType) ? initialType : null,
            placeholder:
                Text(initialType, style: TextStyle(color: activeColor)),
            options: availableTypes
                .map((type) => ShadOption(value: type, child: Text(type)))
                .toList(),
            selectedOptionBuilder: (context, value) => Text(value),
            onChanged: (val) => onTypeSelected(val!),
          ),
        ),
        const SizedBox(width: 4),
        ShadButton.ghost(
          icon: Icon(Icons.add_circle_outline, color: activeColor, size: 20),
          onPressed: onAddNew,
          width: 36,
          height: 36,
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
