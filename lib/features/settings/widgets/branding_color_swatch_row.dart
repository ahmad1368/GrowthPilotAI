import 'package:flutter/material.dart';

/// Fixed preset brand-color palette for the branding settings screen
/// (Issue #257) — no color-picker dependency added; six brand-safe
/// swatches cover the common cases.
class BrandingColorSwatchRow extends StatelessWidget {
  static const presets = ['#2563EB', '#059669', '#DC2626', '#D97706', '#7C3AED', '#0F172A'];

  final String selectedHex;
  final ValueChanged<String> onSelected;

  const BrandingColorSwatchRow({super.key, required this.selectedHex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: presets.map((hex) {
        final isSelected = hex == selectedHex;
        return GestureDetector(
          onTap: () => onSelected(hex),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Color(int.parse('FF${hex.substring(1)}', radix: 16)),
              shape: BoxShape.circle,
              border: isSelected ? Border.all(color: Colors.white, width: 2) : null,
              boxShadow: isSelected ? [const BoxShadow(color: Colors.black26, blurRadius: 4)] : null,
            ),
          ),
        );
      }).toList(),
    );
  }
}
