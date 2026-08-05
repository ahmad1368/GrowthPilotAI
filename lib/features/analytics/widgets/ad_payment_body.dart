import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_ad_package_price.dart';
import 'package:growth_pilot_ai/core/data/entities/ad_payment_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_request_status.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_repos.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_payment_view.dart';

/// Owns the pending-request list and each request's payment outcome (Issue #410).
class AdPaymentBody extends StatefulWidget {
  final List<AdvertisingRequestEntity> requests;

  const AdPaymentBody({super.key, required this.requests});

  @override
  State<AdPaymentBody> createState() => _AdPaymentBodyState();
}

class _AdPaymentBodyState extends State<AdPaymentBody> {
  final _repos = AdPaymentRepos();
  late final _actions = AdPaymentActions(_repos);
  late List<AdvertisingRequestEntity> _requests = widget.requests;
  final _lastPayment = <int, AdPaymentEntity>{};
  List<AdvertisingRequestEntity> get _visible => _requests
      .where((r) => r.status == AdRequestStatus.pending || _lastPayment.containsKey(r.id))
      .toList();
  void _pay(AdvertisingRequestEntity request, {required bool fullAmount}) {
    final price = ComputeAdPackagePrice.call(request.packageType);
    final result = _actions.processPayment(request, fullAmount ? price : price / 2);
    setState(() {
      _lastPayment[request.id] = result.payment;
      _requests = [
        for (final r in _requests)
          if (r.id != request.id) r,
        result.request,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdPaymentView(
      pending: _visible,
      lastPayment: _lastPayment,
      onPayFull: (r) => _pay(r, fullAmount: true),
      onPayPartial: (r) => _pay(r, fullAmount: false),
    );
  }
}
