import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/apply_ad_request_decision.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/advertising_request_repository.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_dialog.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/ad_request_view.dart';

/// Owns the advertising request list (Issue #401), persisting new
/// submissions and admin review decisions immediately.
class AdRequestBody extends StatefulWidget {
  final List<AdvertisingRequestEntity> initialRequests;

  const AdRequestBody({super.key, required this.initialRequests});

  @override
  State<AdRequestBody> createState() => _AdRequestBodyState();
}

class _AdRequestBodyState extends State<AdRequestBody> {
  late List<AdvertisingRequestEntity> _requests = widget.initialRequests;

  Future<void> _submit() async {
    final request = await showAdRequestDialog(context);
    if (request == null) return;
    AdvertisingRequestRepository(
            Get.find<ObjectBox>().store.box<AdvertisingRequestEntity>())
        .save(request);
    setState(() => _requests = [..._requests, request]);
  }

  void _decide(AdvertisingRequestEntity request, bool approved) {
    final decided = ApplyAdRequestDecision.call(request, approved);
    AdvertisingRequestRepository(
            Get.find<ObjectBox>().store.box<AdvertisingRequestEntity>())
        .save(decided);
    setState(() => _requests = [
          for (final r in _requests)
            if (r.id != decided.id) r,
          decided,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return AdRequestView(
      requests: _requests,
      onSubmitRequest: _submit,
      onDecision: _decide,
    );
  }
}
