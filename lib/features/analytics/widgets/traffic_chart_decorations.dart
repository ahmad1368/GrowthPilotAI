import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/traffic_bucket_label.dart';
import 'package:growth_pilot_ai/core/enum/traffic_view.dart';

/// Flat, minimal chart chrome for [TrafficChart] (Issue #365): only a
/// bucket-label X axis (hour or weekday), no grid/Y labels.
class TrafficChartDecorations {
  static FlTitlesData titles(TrafficView view) => FlTitlesData(
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: view == TrafficView.byHour ? 3 : 1,
            getTitlesWidget: (value, meta) => Text(
              TrafficBucketLabel.call(value.toInt(), view),
              style: const TextStyle(fontSize: 9),
            ),
          ),
        ),
      );
}
