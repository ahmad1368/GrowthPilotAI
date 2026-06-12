import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/web_offline_overlay.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';

class InsightPage extends StatelessWidget {
  final ScrollController? controller;
  final Widget child;

  const InsightPage({
    super.key,
    this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final connectivityService = Get.find<ConnectivityService>();

    return Listener(
      onPointerDown: (_) => connectivityService.onUserInteraction(),
      child: Obx(() {
        final bool isOnline = connectivityService.isOnline.value;
        if (kIsWeb && !isOnline) return const WebOfflineOverlay();

        return child;
      }),
    );
  }
}
