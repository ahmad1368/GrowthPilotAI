import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/legal_consent_controller.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/legal_acceptance_step.dart';

/// Gates the real app behind first-run legal acceptance (Issue #168 AC:
/// "registration flow requires active consent") — the #215 consent
/// framework existed but was never actually wired into app boot before
/// this; mirrors [AppLocaleGate]/[OnboardingTourGate]'s pattern.
class LegalConsentGate extends StatefulWidget {
  final Widget child;
  const LegalConsentGate({super.key, required this.child});

  @override
  State<LegalConsentGate> createState() => _LegalConsentGateState();
}

class _LegalConsentGateState extends State<LegalConsentGate> {
  final _controller = Get.find<LegalConsentController>();
  late bool _needsAcceptance = _controller.needsAcceptance;

  @override
  Widget build(BuildContext context) {
    if (_needsAcceptance) {
      return LegalAcceptanceStep(
        controller: _controller,
        onAccepted: () => setState(() => _needsAcceptance = false),
      );
    }
    return widget.child;
  }
}
