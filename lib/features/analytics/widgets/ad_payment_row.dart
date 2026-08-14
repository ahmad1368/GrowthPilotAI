import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_payment_confirmation_narrative.dart';
import 'package:growth_pilot_ai/business/compute_ad_package_price.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One pending request row (Issue #410) — SKU price plus
/// simulate-payment controls or the confirmation once captured.
class AdPaymentRow extends StatelessWidget {
  final AdvertisingRequestEntity request;
  final AdPaymentEntity? lastPayment;
  final VoidCallback onPayFull;
  final VoidCallback onPayPartial;

  const AdPaymentRow({
    super.key,
    required this.request,
    required this.lastPayment,
    required this.onPayFull,
    required this.onPayPartial,
  });
  @override
  Widget build(BuildContext context) {
    final price = ComputeAdPackagePrice.call(request.packageType);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(
                  '${request.merchantName} — ${request.packageType.name} (\$${price.toStringAsFixed(0)})')),
              if (lastPayment?.status != PaymentVerificationStatus.verified) ...[
                ShadButton.ghost(onPressed: onPayFull, child: const Text('Simulate Payment')),
                ShadButton.ghost(onPressed: onPayPartial, child: const Text('Simulate Underpayment')),
              ],
            ],
          ),
          if (lastPayment != null)
            Text(BuildPaymentConfirmationNarrative.call(request, lastPayment!.status),
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
