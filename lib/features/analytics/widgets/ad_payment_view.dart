import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_row.dart';

/// Renders every pending request awaiting payment activation (Issue
/// #410). Purely presentational.
class AdPaymentView extends StatelessWidget {
  final List<AdvertisingRequestEntity> pending;
  final Map<int, AdPaymentEntity> lastPayment;
  final void Function(AdvertisingRequestEntity) onPayFull;
  final void Function(AdvertisingRequestEntity) onPayPartial;

  const AdPaymentView({
    super.key,
    required this.pending,
    required this.lastPayment,
    required this.onPayFull,
    required this.onPayPartial,
  });

  @override
  Widget build(BuildContext context) {
    if (pending.isEmpty) {
      return const Text('No advertising requests awaiting payment.');
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final request in pending)
          AdPaymentRow(
            request: request,
            lastPayment: lastPayment[request.id],
            onPayFull: () => onPayFull(request),
            onPayPartial: () => onPayPartial(request),
          ),
      ],
    );
  }
}
