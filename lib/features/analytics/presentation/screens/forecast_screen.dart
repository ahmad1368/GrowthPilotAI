import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/utils/forecast_engine.dart';
import '../widgets/forecast_chart.dart';
import '../widgets/forecast_summary_card.dart';

/// Spending-forecast page: renders a recent daily-spending history extended by
/// a dashed prediction from [ForecastEngine]. The chart is the data consumer;
/// the sample series stands in until it is bound to the live controller.
class ForecastScreen extends StatelessWidget {
  const ForecastScreen({super.key});

  static const List<double> _sampleHistory = [
    40, 52, 48, 61, 55, 70, 66, 80, 74, 90, 88, 102, 96, 110,
  ];

  @override
  Widget build(BuildContext context) {
    final forecast = ForecastEngine.predictNext(_sampleHistory, 7);
    return Scaffold(
      appBar: AppBar(title: const Text('Spending Forecast')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ForecastSummaryCard(history: _sampleHistory, forecast: forecast),
          const SizedBox(height: 20),
          SizedBox(
            height: 320,
            child: ForecastChart(
              historical: _sampleHistory,
              forecast: forecast,
            ),
          ),
        ],
      ),
    );
  }
}
