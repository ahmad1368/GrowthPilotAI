import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/controllers/legal_consent_controller.dart';
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
    return Padding(
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
    );
  }
}
