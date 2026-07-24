import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/widgets/live_preview_badge.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/radar_chart_data_builder.dart';

/// The Business Compass radar (Issue #84): the sector benchmark ("Ghost")
/// behind the user's own data ("Live"). Flat fills per the current design
/// system — no glow/blur despite the original issue's literal
/// Glassmorphism ask.
class BusinessRadarChart extends StatelessWidget {
  final BusinessCompassMetrics userMetrics;
  final BusinessCompassMetrics sectorMetrics;

  /// Issue #115's config side-panel toggle: hides the sector "Ghost"
  /// overlay when the user only wants to see their own numbers.
  final bool showSectorOverlay;

  /// Issue #116: true while [showSectorOverlay] reflects an unsaved
  /// side-panel edit. Shows a "Live" badge; [RepaintBoundary] below keeps
  /// this preview loop from repainting the rest of the Gridded Canvas
  /// (#113).
  final bool isLivePreview;

  const BusinessRadarChart({
    super.key,
    required this.userMetrics,
    required this.sectorMetrics,
    this.showSectorOverlay = true,
    this.isLivePreview = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return RepaintBoundary(
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: RadarChart(RadarChartDataBuilder.build(
              userMetrics: userMetrics,
              sectorMetrics: sectorMetrics,
              showSectorOverlay: showSectorOverlay,
              primary: primary,
            )),
          ),
          if (isLivePreview)
            const Positioned(top: 0, right: 0, child: LivePreviewBadge()),
        ],
      ),
    );
  }
}
