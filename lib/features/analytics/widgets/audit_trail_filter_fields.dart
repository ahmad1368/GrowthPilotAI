import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Admin/merchant search filters for the audit trail (Issue #343,
/// acceptance criterion 2).
class AuditTrailFilterFields extends StatelessWidget {
  final ValueChanged<String> onAdminChanged;
  final ValueChanged<String> onMerchantChanged;

  const AuditTrailFilterFields({
    super.key,
    required this.onAdminChanged,
    required this.onMerchantChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: ShadInput(
                placeholder: const Text('Filter by admin'), onChanged: onAdminChanged)),
        const SizedBox(width: 8),
        Expanded(
            child: ShadInput(
                placeholder: const Text('Filter by merchant'),
                onChanged: onMerchantChanged)),
      ],
    );
  }
}
