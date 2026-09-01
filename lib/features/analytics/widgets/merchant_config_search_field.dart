import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Advanced search box filtering merchant profiles by business name or
/// ID as the admin types (Issue #338, acceptance criterion 1).
class MerchantConfigSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const MerchantConfigSearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      placeholder: const Text('Search by business name or ID'),
      onChanged: onChanged,
    );
  }
}
