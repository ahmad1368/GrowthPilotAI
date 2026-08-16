import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/compute_kpi_total.dart';
import 'package:growth_pilot_ai/business/group_transactions_by_day.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/insight_visual_hint.dart';
import 'package:growth_pilot_ai/core/models/ai_insight_response.dart';
import 'package:growth_pilot_ai/features/insights/widgets/insight_bar_chart.dart';
import 'package:growth_pilot_ai/features/insights/widgets/insight_kpi_card.dart';
import 'package:growth_pilot_ai/features/insights/widgets/insight_transaction_list.dart';
import 'package:growth_pilot_ai/features/insights/widgets/insight_view_switch_button.dart';

/// "The Factory" (Issue #261): AnimatedSwitcher container that renders
/// whichever view [AiInsightResponse.visualHint] picked, with a manual
/// override via [InsightViewSwitchButton] (AC: "Manual Toggle").
class DynamicInsightWidget extends StatefulWidget {
  final AiInsightResponse response;
  final List<TransactionEntity> results;

  const DynamicInsightWidget({super.key, required this.response, required this.results});

  @override
  State<DynamicInsightWidget> createState() => _DynamicInsightWidgetState();
}

class _DynamicInsightWidgetState extends State<DynamicInsightWidget> {
  late InsightVisualHint _hint = widget.response.visualHint;

  void _cycleView() {
    const order = InsightVisualHint.values;
    setState(() => _hint = order[(_hint.index + 1) % order.length]);
  }

  Widget _content() {
    switch (_hint) {
      case InsightVisualHint.chart:
        return InsightBarChart(
            key: const ValueKey('chart'), points: GroupTransactionsByDay.call(widget.results));
      case InsightVisualHint.kpi:
        return InsightKpiCard(
            key: const ValueKey('kpi'),
            total: ComputeKpiTotal.call(widget.results),
            summary: widget.response.aiSummary);
      case InsightVisualHint.list:
        return InsightTransactionList(key: const ValueKey('list'), transactions: widget.results);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        InsightViewSwitchButton(onTap: _cycleView),
        AnimatedSwitcher(duration: const Duration(milliseconds: 250), child: _content()),
      ],
    );
  }
}
