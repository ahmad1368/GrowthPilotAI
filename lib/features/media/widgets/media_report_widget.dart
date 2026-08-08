import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/abstracts/base_report_widget.dart';
import 'package:growth_pilot_ai/features/media/widgets/media_body.dart';

/// Registers the Image Optimization demo (Issue #139) as a pluggable
/// report widget under id `IMAGE_OPTIMIZATION_ENGINE` (#111).
class MediaReportWidget extends BaseReportWidget {
  const MediaReportWidget({super.key, required super.data, required super.title});

  @override
  Widget buildContent(BuildContext context) {
    return const MediaBody();
  }
}
