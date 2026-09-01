import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/deep_link_controller.dart';

/// Eagerly instantiates [DeepLinkController] (Issue #176) the same
/// way [ConnectivityGate] forces `ConnectivityService` alive on app
/// start — the controller does nothing further after `onInit` starts
/// its link listener.
class DeepLinkGate extends StatelessWidget {
  final Widget child;
  const DeepLinkGate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    Get.find<DeepLinkController>();
    return child;
  }
}
