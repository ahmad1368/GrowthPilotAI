import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';
import '../widgets/forecast_chart.dart';
import '../widgets/forecast_summary_card.dart';

/// Spending-forecast page: renders a recent daily-spending history
/// extended by a dashed prediction from [ForecastEngine]. [_days] (edited
/// live via ForecastSummaryCard's numeric input, Issue #810) is now the
/// single source of truth for both the chart's forecast horizon and the
/// summary card's window — previously the chart used a hardcoded 7-day
/// horizon independent of the card's own window selection.
class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  static const List<double> _sampleHistory = [
    40, 52, 48, 61, 55, 70, 66, 80, 74, 90, 88, 102, 96, 110,
  ];

  int _days = 7;

  @override
  Widget build(BuildContext context) {
    final forecast = ForecastEngine.predictNext(_sampleHistory, _days);
    return Scaffold(
      appBar: AppBar(title: const Text('Spending Forecast')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ForecastSummaryCard(
            history: _sampleHistory,
            forecast: forecast,
            days: _days,
            onDaysChanged: (d) => setState(() => _days = d),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 320,
            child: ForecastChart(historical: _sampleHistory, forecast: forecast),
          ),
        ],
      ),
    );
  }
}
