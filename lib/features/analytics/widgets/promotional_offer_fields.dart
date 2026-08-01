import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// The offer text/target-filter/sent/opened/used fields for a new
/// logged promotional offer dispatch (Issue #335).
class PromotionalOfferFields extends StatelessWidget {
  final TextEditingController offerTextController;
  final TextEditingController targetFilterController;
  final TextEditingController sentCountController;
  final TextEditingController openedCountController;
  final TextEditingController usedCountController;

  const PromotionalOfferFields({
    super.key,
    required this.offerTextController,
    required this.targetFilterController,
    required this.sentCountController,
    required this.openedCountController,
    required this.usedCountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Offer text'), controller: offerTextController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Target category or neighborhood'),
            controller: targetFilterController),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Merchants sent to'),
            controller: sentCountController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Merchants opened'),
            controller: openedCountController,
            keyboardType: TextInputType.number),
        const SizedBox(height: 8),
        ShadInput(
            placeholder: const Text('Merchants used offer'),
            controller: usedCountController,
            keyboardType: TextInputType.number),
      ],
    );
  }
}
