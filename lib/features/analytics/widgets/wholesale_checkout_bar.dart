import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Buyer-name input and cart checkout button (Issue #411, acceptance
/// criterion 3) — split out of [WholesaleView] to stay under the file
/// line cap.
class WholesaleCheckoutBar extends StatelessWidget {
  final TextEditingController buyerController;
  final int cartSize;
  final VoidCallback? onCheckout;

  const WholesaleCheckoutBar({
    super.key,
    required this.buyerController,
    required this.cartSize,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ShadInput(
              placeholder: const Text('Buyer merchant name'), controller: buyerController)),
      const SizedBox(width: 8),
      ShadButton(onPressed: onCheckout, child: Text('Checkout Cart ($cartSize)')),
    ]);
  }
}
