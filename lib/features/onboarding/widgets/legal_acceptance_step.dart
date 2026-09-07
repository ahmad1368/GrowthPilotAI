import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/legal_consent_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/legal_acceptance_checkbox.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// First-run "Legal Acceptance" step (Issue #215) — the Continue button
/// stays disabled until the checkbox is ticked (AC: "No Access without
/// Consent"), reusable for the version-mismatch re-acceptance prompt too.
class LegalAcceptanceStep extends StatefulWidget {
  final LegalConsentController controller;
  final VoidCallback onAccepted;

  const LegalAcceptanceStep({super.key, required this.controller, required this.onAccepted});

  @override
  State<LegalAcceptanceStep> createState() => _LegalAcceptanceStepState();
}

class _LegalAcceptanceStepState extends State<LegalAcceptanceStep> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    // ShadCheckbox/ShadButton need a ShadTheme ancestor (Issue #189) —
    // this step has none otherwise, matching the same self-wrap pattern
    // every other shadcn_ui-consuming screen in this app already uses.
    return ShadTheme(
      data: AppShadTheme.build(Theme.of(context).brightness),
      // [Issue #792] Unlike every other full-screen gate widget
      // in this app (e.g. LoginScreen), this step returned bare content
      // with no Scaffold — under GetMaterialApp's AnimatedSwitcher/Navigator
      // transition it could receive unbounded height and crash with
      // "RenderCustomMultiChildLayoutBox object was given an infinite size
      // during layout" / a bottom overflow. Scaffold > SafeArea >
      // SingleChildScrollView mirrors LoginScreen's established pattern.
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegalAcceptanceCheckbox(checked: _checked, onChanged: (v) => setState(() => _checked = v)),
                const SizedBox(height: 16),
                ShadButton(
                  enabled: _checked,
                  onPressed: _checked
                      ? () {
                          widget.controller.accept(dataUsageConsent: true);
                          widget.onAccepted();
                        }
                      : null,
                  child: const Text('Continue'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
