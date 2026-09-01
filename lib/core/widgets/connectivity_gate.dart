import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/should_block_web_interactions.dart';
import 'package:growth_pilot_ai/core/widgets/web_offline_overlay.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

/// Wraps the app with the Web-only blocking offline overlay (Issue
/// #263) — on Mobile, [child] is always interactive; Mobile's offline
/// handling is graceful local-first degradation (this app's ObjectBox
/// default), not a blocking barrier.
class ConnectivityGate extends StatelessWidget {
  final Widget child;

  const ConnectivityGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final connectivity = Get.find<ConnectivityService>();
    return Stack(
      children: [
        child,
        Obx(() {
          final blocked = ShouldBlockWebInteractions.call(
              isWeb: kIsWeb, isOnline: connectivity.isOnline.value);
          return blocked ? const WebOfflineOverlay() : const SizedBox.shrink();
        }),
      ],
    );
  }
}
