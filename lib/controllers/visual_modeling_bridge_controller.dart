import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:growth_pilot_ai/business/parse_flutter_bridge_message.dart';
import 'package:growth_pilot_ai/core/models/canvas_bridge_message.dart';
import 'package:growth_pilot_ai/core/utils/canvas_placeholder_html.dart';

/// Drives the `FlutterBridge` JS channel (Issue #220) — no real Next.js/
/// React Flow `/canvas-lite` app exists yet, so this loads the bundled
/// placeholder page instead (see PR notes).
class VisualModelingBridgeController extends GetxController {
  late final WebViewController webViewController;
  final latestMessage = Rxn<CanvasBridgeMessage>();

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
    if (parsed != null) latestMessage.value = parsed;
  }
}
