import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Filters the merchant list down to a single assigned tag as the admin
/// types (Issue #342, acceptance criterion 2).
class MerchantTagFilterField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const MerchantTagFilterField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Filter by tag'),
      onChanged: onChanged,
    );
  }
}
