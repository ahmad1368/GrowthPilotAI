import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_traffic_narrative.dart';
import 'package:growth_pilot_ai/business/compute_traffic_distribution.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_chart.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_view_chips.dart';

/// Body of the Peak Hours Customer Traffic widget (Issue #365): a local
/// By Hour/By Day toggle recomputes [ComputeTrafficDistribution] from
/// transaction timestamps on-device.
class TrafficReportBody extends StatefulWidget {
  final List<TransactionEntity> transactions;

  const TrafficReportBody({super.key, required this.transactions});

  @override
  State<TrafficReportBody> createState() => _TrafficReportBodyState();
}

class _TrafficReportBodyState extends State<TrafficReportBody> {
  var _view = TrafficView.byHour;

  @override
  Widget build(BuildContext context) {
    final points =
        ComputeTrafficDistribution.call(widget.transactions, _view);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TrafficViewChips(
          selected: _view,
          onChanged: (v) => setState(() => _view = v),
        ),
        const SizedBox(height: 12),
        TrafficChart(points: points, view: _view),
        const SizedBox(height: 8),
        Text(BuildTrafficNarrative.call(points, _view)),
      ],
    );
  }
}
