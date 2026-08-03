import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The merchant/service/reason fields and blocked toggle for a new
/// logged service restriction decision (Issue #337).
class ServiceRestrictionFields extends StatelessWidget {
  final TextEditingController merchantNameController;
  final TextEditingController serviceNameController;
  final TextEditingController reasonMessageController;
  final bool isBlocked;
  final ValueChanged<bool> onBlockedChanged;

  const ServiceRestrictionFields({
    super.key,
    required this.merchantNameController,
    required this.serviceNameController,
    required this.reasonMessageController,
    required this.isBlocked,
    required this.onBlockedChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Merchant name'),
            controller: merchantNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Service (e.g. Marketplace, Analytics)'),
            controller: serviceNameController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Reason shown to the user'),
            controller: reasonMessageController),
        const SizedBox(height: 8),
        ShadSwitch(
          value: isBlocked,
          label: const Text('Block this service'),
          onChanged: onBlockedChanged,
        ),
      ],
    );
  }
}
