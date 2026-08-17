import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/field_visibility.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One "Inline Indicator" row (Issue #218): Lock/Globe icon that toggles
/// on tap, with color coding (green = public, slate = private, per the
/// AC's "Visual Color Coding").
class PrivacyFieldToggleRow extends StatelessWidget {
  final String label;
  final FieldVisibility visibility;
  final VoidCallback onTap;

  const PrivacyFieldToggleRow({
    super.key,
    required this.label,
    required this.visibility,
    required this.onTap,
  });

  bool get _isPublic => visibility == FieldVisibility.public;

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final accent = _isPublic ? Colors.green : colors.mutedForeground;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Row(
          children: [
            Icon(_isPublic ? Icons.public : Icons.lock, color: accent, size: 18),
            const SizedBox(width: 10),
            Expanded(child: Text(label, style: TextStyle(color: colors.foreground, fontSize: 14))),
            Text(_isPublic ? 'Public' : 'Private',
                style: TextStyle(color: accent, fontSize: 12, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
