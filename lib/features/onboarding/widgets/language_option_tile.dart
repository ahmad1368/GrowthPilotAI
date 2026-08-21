import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// One selectable language row in the first-launch setup wizard
/// (Issue #429, acceptance criterion 2). [isSuggested] highlights the
/// device's detected system locale (Issue #179 AC: "System
/// Detection") without forcing it — the user still taps to confirm.
class LanguageOptionTile extends StatelessWidget {
  final AppLocale locale;
  final VoidCallback onTap;
  final bool isSuggested;

  const LanguageOptionTile({super.key, required this.locale, required this.onTap, this.isSuggested = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: isSuggested
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: theme.colorScheme.primary, width: 1.5))
          : null,
      child: ListTile(
        title: Text(locale.nativeName),
        subtitle:
            isSuggested ? Text('onboarding_suggested_language'.tr, style: const TextStyle(fontSize: 11)) : null,
        trailing: locale.isRtl ? const Text('RTL', style: TextStyle(fontSize: 10)) : null,
        onTap: onTap,
      ),
    );
  }
}
