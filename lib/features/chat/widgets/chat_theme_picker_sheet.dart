import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/settings/widgets/branding_color_swatch_row.dart';

/// "Custom Chat Themes, Hex Color Pickers" (Issue #317 feature #25) —
/// reuses #257's [BrandingColorSwatchRow] preset palette rather than
/// adding a full color-picker dependency for a per-room accent.
void showChatThemePickerSheet(
  BuildContext context, {
  required String? currentHex,
  required void Function(String?) onSelect,
}) {
  showModalBottomSheet(
    context: context,
    builder: (sheetContext) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Chat theme color', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          BrandingColorSwatchRow(
            selectedHex: currentHex ?? '',
            onSelected: (hex) {
              Navigator.of(sheetContext).pop();
              onSelect(hex);
            },
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.of(sheetContext).pop();
              onSelect(null);
            },
            child: const Text('Reset to default'),
          ),
        ]),
      ),
    ),
  );
}
