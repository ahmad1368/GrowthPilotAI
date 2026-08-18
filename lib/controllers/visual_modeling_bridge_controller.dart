import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:growth_pilot_ai/business/parse_flutter_bridge_message.dart';
import 'package:growth_pilot_ai/business/parse_save_status.dart';
import 'package:growth_pilot_ai/core/enum/canvas_save_status.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';
import 'package:growth_pilot_ai/core/utils/canvas_placeholder_html.dart';

/// Drives the `FlutterBridge` JS channel (Issue #220/#222) — no real
/// Next.js/React Flow `/canvas-lite` app exists yet, so this loads the
/// bundled placeholder page instead (see PR notes).
class VisualModelingBridgeController extends GetxController {
  late final WebViewController webViewController;
  final latestMessage = Rxn<CanvasBridgeMessage>();
  final saveStatus = CanvasSaveStatus.idle.obs;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel('FlutterBridge', onMessageReceived: _onBridgeMessage)
      ..loadHtmlString(canvasPlaceholderHtml);
  }

  void _onBridgeMessage(JavaScriptMessage message) {
    final parsed = ParseFlutterBridgeMessage.call(message.message);
    if (parsed == null) return;
    latestMessage.value = parsed;
    final status = ParseSaveStatus.call(parsed);
    if (status != null) saveStatus.value = status;
  }
}
