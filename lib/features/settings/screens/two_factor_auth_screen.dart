import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/two_factor_auth_controller.dart';

/// TOTP 2FA enrollment/disable screen (Issue #317 feature #3) — no QR
/// image rendered (no qr_flutter dependency), manual entry only; see
/// PR notes.
class TwoFactorAuthScreen extends StatefulWidget {
  const TwoFactorAuthScreen({super.key});

  @override
  State<TwoFactorAuthScreen> createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {
  final _controller = Get.find<TwoFactorAuthController>();
  final _code = TextEditingController();
  String? _provisioningUri;
  String? _error;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final ok = await _controller.confirmEnrollment(_code.text.trim());
    setState(() => _error = ok ? null : 'Invalid or expired code');
    if (ok) setState(() => _provisioningUri = null);
  }

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: const Text('Two-Factor Authentication'), backgroundColor: colors.background),
      body: Obx(() {
        if (_controller.isEnabled.value) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('2FA is enabled', style: TextStyle(color: colors.foreground, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ShadButton.destructive(onPressed: _controller.disable, child: const Text('Disable 2FA')),
            ]),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (_provisioningUri == null)
              ShadButton(
                onPressed: () => setState(() => _provisioningUri = _controller.startEnrollment()),
                child: const Text('Enable 2FA'),
              )
            else ...[
              Text('Add this key to your authenticator app (manual entry):',
                  style: TextStyle(color: colors.foreground)),
              const SizedBox(height: 8),
              SelectableText(_provisioningUri!, style: TextStyle(color: colors.mutedForeground, fontSize: 12)),
              const SizedBox(height: 16),
              ShadInput(controller: _code, placeholder: const Text('6-digit code')),
              if (_error != null) ...[
                const SizedBox(height: 4),
                Text(_error!, style: TextStyle(color: colors.destructive, fontSize: 12)),
              ],
              const SizedBox(height: 12),
              ShadButton(onPressed: _confirm, child: const Text('Confirm')),
            ],
          ]),
        );
      }),
    );
  }
}
