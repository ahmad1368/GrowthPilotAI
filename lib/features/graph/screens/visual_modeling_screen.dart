import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:growth_pilot_ai/business/should_warn_before_leaving_canvas.dart';
import 'package:growth_pilot_ai/controllers/visual_modeling_bridge_controller.dart';
import 'package:growth_pilot_ai/features/graph/widgets/requirement_edit_bottom_sheet.dart';
import 'package:growth_pilot_ai/features/graph/widgets/save_status_indicator.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Visual Modeling" screen hosting the `FlutterBridge` WebView (Issue
/// #220/#222) — `webview_flutter` has no Web-platform implementation
/// bundled here, so on Web this shows a flat fallback instead of
/// failing to compile/render (architecture rule: guard native-only
/// packages with `kIsWeb`).
class VisualModelingScreen extends StatelessWidget {
  const VisualModelingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final colors = ShadTheme.of(context).colorScheme;
      return Center(
        child: Text('Visual Modeling is not available on Web yet.',
            style: TextStyle(color: colors.mutedForeground)),
      );
    }

    final controller = Get.put(VisualModelingBridgeController());
    ever(controller.latestMessage, (msg) async {
      if (msg?.event != 'onNodeDoubleClick') return;
      final label = msg!.payload['label']?.toString() ?? '';
      await showModalBottomSheet<String>(
        context: context,
        builder: (_) => RequirementEditBottomSheet(initialLabel: label),
      );
    });

    return PopScope(
      canPop: !ShouldWarnBeforeLeavingCanvas.call(controller.saveStatus.value),
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Changes are still saving, please wait.')),
        );
      },
      child: Column(
        children: [
          SaveStatusIndicator(controller: controller),
          Expanded(child: WebViewWidget(controller: controller.webViewController)),
        ],
      ),
    );
  }
}
