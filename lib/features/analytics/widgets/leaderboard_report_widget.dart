import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/merchant_config_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/leaderboard_body.dart';

/// Registers the Top Ranks Leaderboard (Issue #408) as a pluggable
/// report widget under id `TOP_RANKS_LEADERBOARD` (#111).
class LeaderboardReportWidget extends BaseReportWidget {
  const LeaderboardReportWidget(
      {super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return LeaderboardBody(
      configs: data['configs'] as List<MerchantConfigEntity>,
      requests: data['adRequests'] as List<AdvertisingRequestEntity>,
    );
  }
}
