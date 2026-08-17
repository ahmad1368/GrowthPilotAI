import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Active Consent" checkbox (Issue #215) — a physical tap is required;
/// nothing defaults to checked.
class LegalAcceptanceCheckbox extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool> onChanged;

  const LegalAcceptanceCheckbox({super.key, required this.checked, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return InkWell(
      onTap: () => onChanged(!checked),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(value: checked, onChanged: (v) => onChanged(v ?? false)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'I agree to the Terms of Service and Privacy Policy',
              style: TextStyle(color: colors.foreground, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
