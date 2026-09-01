import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Company name input for the branding settings screen (Issue #257)
/// — owns its own `TextEditingController` so typing doesn't rebuild
/// the whole screen via `Obx`.
class BrandingCompanyNameField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const BrandingCompanyNameField({super.key, required this.initialValue, required this.onChanged});

  @override
  State<BrandingCompanyNameField> createState() => _BrandingCompanyNameFieldState();
}

class _BrandingCompanyNameFieldState extends State<BrandingCompanyNameField> {
  late final TextEditingController _controller = TextEditingController(text: widget.initialValue);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadInput(
      controller: _controller,
      placeholder: const Text('e.g. Acme Consulting'),
      onChanged: widget.onChanged,
    );
  }
}
