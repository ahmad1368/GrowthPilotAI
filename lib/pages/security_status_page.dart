import 'package:flutter/material.dart';

/// Data security summary (Issue #16).
///
/// This previously claimed the local database was "encrypted with
/// AES-256", stored a "hardware-backed key", and had "biometric
/// protection" - none of which is true. ObjectBox's password/at-rest
/// encryption parameter isn't available in this project's package
/// version (verified: openStore() in objectbox.g.dart has no such
/// parameter), and the field-level cipher built for Issue #262
/// (TransactionFieldCipher) is explicitly not wired into
/// TransactionEntity/TransactionRepository yet - its own doc comment
/// says so. Rewritten to describe only what actually protects local
/// data today, per this repo's flat design system (no
/// glassmorphism/legacy widgets).
class SecurityStatusPage extends StatelessWidget {
  const SecurityStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Data Security')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Icon(Icons.shield_outlined, size: 64, color: theme.colorScheme.primary),
          const SizedBox(height: 20),
          Text(
            'Your data stays on this device',
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const Divider(height: 40),
          _buildSecurityFeature(
            context,
            Icons.smartphone_rounded,
            'App Sandbox',
            "Local data is stored in this app's private, OS-protected "
                'storage - other apps cannot read it directly.',
          ),
          _buildSecurityFeature(
            context,
            Icons.wifi_off_rounded,
            'Local-Only by Default',
            'Transactions are processed and stored on-device; nothing is '
                'sent to an external server unless you explicitly enable sync.',
          ),
          _buildSecurityFeature(
            context,
            Icons.lock_outline_rounded,
            'Encryption at Rest',
            'Not yet enabled - planned as a future update.',
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityFeature(
      BuildContext context, IconData icon, String title, String subtitle) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleSmall),
                Text(subtitle, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
