import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/kyc_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/kyc/kyc_status_banner.dart';
import 'package:growth_pilot_ai/features/kyc/pick_kyc_document.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Verification Center" (Issue #144) — flat shadcn_ui, not the issue's
/// literal Glassmorphism ask. Not yet wired into app navigation.
class KycVerificationScreen extends StatefulWidget {
  final String userId;
  const KycVerificationScreen({super.key, required this.userId});

  @override
  State<KycVerificationScreen> createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
  late final KycController _controller;
  Uint8List? _idBytes;
  Uint8List? _businessBytes;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(KycController(), tag: widget.userId);
    _controller.loadFor(widget.userId);
  }

  @override
  void dispose() {
    Get.delete<KycController>(tag: widget.userId);
    super.dispose();
  }

  Future<void> _submit() async {
    if (_idBytes == null || _businessBytes == null) return;
    await _controller.submit(widget.userId, _idBytes!, _businessBytes!);
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return ShadTheme(
      data: AppShadTheme.build(brightness),
      child: Scaffold(
        backgroundColor: brightness == Brightness.dark
            ? const Color(0xFF09090B)
            : const Color(0xFFFFFFFF),
        appBar: AppBar(title: const Text('Identity Verification')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                KycStatusBanner(
                    status: _controller.status.value, rejectionReason: _controller.rejectionReason.value),
                const SizedBox(height: 16),
                ShadButton.ghost(
                    onPressed: () async {
                      final bytes = await pickKycDocument();
                      if (bytes != null) setState(() => _idBytes = bytes);
                    },
                    child: Text(_idBytes == null ? 'Capture ID document' : 'ID captured')),
                const SizedBox(height: 8),
                ShadButton.ghost(
                    onPressed: () async {
                      final bytes = await pickKycDocument();
                      if (bytes != null) setState(() => _businessBytes = bytes);
                    },
                    child: Text(_businessBytes == null
                        ? 'Capture business registration'
                        : 'Business document captured')),
                const SizedBox(height: 16),
                ShadButton(
                    onPressed: (_idBytes != null && _businessBytes != null) ? _submit : null,
                    child: const Text('Submit for verification')),
              ])),
        ),
      ),
    );
  }
}
