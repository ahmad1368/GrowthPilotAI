import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_panel.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_compass_actions.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_compass_body.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Business Compass screen (Issue #84) on the pluggable report widget
/// registry (#111) + masonry canvas (#113), with drag reordering (#114),
/// a config side-panel (#115) and its live-preview bridge (#116). Flat
/// shadcn_ui, not the issues' literal Glassmorphism ask.
class BusinessCompassScreen extends StatefulWidget {
  const BusinessCompassScreen({super.key});

  @override
  State<BusinessCompassScreen> createState() => _BusinessCompassScreenState();
}

class _BusinessCompassScreenState extends State<BusinessCompassScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _reordering = false;

  @override
  void initState() {
    super.initState();
    final specs = Get.find<BusinessCompassController>().reportSpecs;
    Get.find<WidgetLayoutController>()
        .loadFor(specs.map((s) => s.id).toList());
    Get.find<WidgetConfigController>().loadAll();
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(
          title: const Text('Business Compass'),
          actions: [
            BusinessCompassActions(
              reordering: _reordering,
              onToggleReorder: () =>
                  setState(() => _reordering = !_reordering),
              onOpenConfig: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ],
        ),
        endDrawer: WidgetConfigPanel(
            specs: Get.find<BusinessCompassController>().reportSpecs),
        // Issue #116: a side-panel closed without hitting Apply must revert
        // its chart(s) to the last saved state, not leave a stale preview.
        onEndDrawerChanged: (isOpen) {
          if (!isOpen) Get.find<WidgetPreviewController>().discardAll();
        },
        body: BusinessCompassBody(reordering: _reordering),
      ),
    );
  }
}
