import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// One selectable language row in the first-launch setup wizard
/// (Issue #429, acceptance criterion 2).
class LanguageOptionTile extends StatelessWidget {
  final AppLocale locale;
  final VoidCallback onTap;

  const LanguageOptionTile({super.key, required this.locale, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        title: Text(locale.nativeName),
        trailing: locale.isRtl ? const Text('RTL', style: TextStyle(fontSize: 10)) : null,
        onTap: onTap,
      ),
    );
  }
}
