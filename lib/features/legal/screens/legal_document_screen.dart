import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/legal/privacy_policy_text.dart';
import 'package:growth_pilot_ai/core/legal/terms_of_service_text.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders the Terms of Service + Privacy Policy (Issue #168's AC:
/// "accessible via a Legal menu") — self-wraps in ShadTheme since no
/// global one exists in this app (see the crash fixed in #189).
class LegalDocumentScreen extends StatelessWidget {
  const LegalDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shadTheme = AppShadTheme.build(Theme.of(context).brightness);
    final colors = shadTheme.colorScheme;

    return ShadTheme(
      data: shadTheme,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(title: const Text('Legal'), backgroundColor: colors.background),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Terms of Service', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(termsOfServiceText, style: TextStyle(color: colors.mutedForeground, fontSize: 13, height: 1.5)),
            const SizedBox(height: 32),
            Text('Privacy Policy', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            Text(privacyPolicyText, style: TextStyle(color: colors.mutedForeground, fontSize: 13, height: 1.5)),
          ]),
        ),
      ),
    );
  }
}
