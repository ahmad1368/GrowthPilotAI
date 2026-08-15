import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/should_show_onboarding.dart';
import 'package:growth_pilot_ai/controllers/onboarding_controller.dart';
import 'package:growth_pilot_ai/features/onboarding/screens/onboarding_tour_screen.dart';

/// Gates the real app behind the first-launch feature tour (Issue #162)
/// — shown once, right after language setup ([AppLocaleGate]).
class OnboardingTourGate extends StatefulWidget {
  final Widget child;
  const OnboardingTourGate({super.key, required this.child});

  @override
  State<OnboardingTourGate> createState() => _OnboardingTourGateState();
}

class _OnboardingTourGateState extends State<OnboardingTourGate> {
  final _controller = Get.put(OnboardingController(), permanent: true);
  late bool _ready = _controller.restored;
  late bool _showTour =
      _controller.restored && ShouldShowOnboarding.call(_controller.hasCompletedOrSkipped);

  @override
  void initState() {
    super.initState();
    if (!_controller.restored) _restore();
  }

  Future<void> _restore() async {
    await _controller.restore();
    if (mounted) {
      setState(() {
        _showTour = ShouldShowOnboarding.call(_controller.hasCompletedOrSkipped);
        _ready = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const SizedBox.shrink();
    if (_showTour) {
      return OnboardingTourScreen(onDone: () => setState(() => _showTour = false));
    }
    return widget.child;
  }
}
