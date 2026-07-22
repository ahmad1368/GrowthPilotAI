import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_compass_body.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Business Compass screen (Issue #84): the user's "Success DNA" radar vs.
/// a mocked sector benchmark (Issue #83), rendered through the pluggable
/// report widget registry (Issue #111) on a masonry canvas (Issue #113)
/// with long-press drag reordering (Issue #114). Flat shadcn_ui per the
/// current design system, not the original issues' Glassmorphism ask.
class BusinessCompassScreen extends StatefulWidget {
  const BusinessCompassScreen({super.key});

  @override
  State<BusinessCompassScreen> createState() => _BusinessCompassScreenState();
}

class _BusinessCompassScreenState extends State<BusinessCompassScreen> {
  var _reordering = false;

  @override
  void initState() {
    super.initState();
    final specs = Get.find<BusinessCompassController>().reportSpecs;
    Get.find<WidgetLayoutController>()
        .loadFor(specs.map((s) => s.id).toList());
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: const Text('Business Compass'),
          actions: [
            IconButton(
              icon: Icon(_reordering ? Icons.check : Icons.reorder),
              tooltip: _reordering ? 'Done reordering' : 'Reorder widgets',
              onPressed: () => setState(() => _reordering = !_reordering),
            ),
          ],
        ),
        body: BusinessCompassBody(reordering: _reordering),
      ),
    );
  }
}
