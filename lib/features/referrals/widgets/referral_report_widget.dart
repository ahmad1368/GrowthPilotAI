import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_body.dart';

/// Registers the Privacy-Safe Non-User Invitation and Double-Sided
/// Incentive Engine (Issue #542) as a pluggable report widget under
/// id `REFERRAL_INVITATION_ENGINE` (#111).
class ReferralReportWidget extends BaseReportWidget {
  const ReferralReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const ReferralBody();
  }
}
