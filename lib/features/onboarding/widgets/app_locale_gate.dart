import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/locale_controller.dart';
import 'package:growth_pilot_ai/features/onboarding/screens/language_setup_screen.dart';

/// Gates the real app behind first-launch language selection (Issue
/// #429, acceptance criterion 2) — restores a persisted locale if one
/// exists, otherwise shows [LanguageSetupScreen] once before handing
/// off to [child].
class AppLocaleGate extends StatefulWidget {
  final Widget child;
  const AppLocaleGate({super.key, required this.child});

  @override
  State<AppLocaleGate> createState() => _AppLocaleGateState();
}

class _AppLocaleGateState extends State<AppLocaleGate> {
  final _controller = Get.put(LocaleController(), permanent: true);
  late bool _ready = _controller.restored;
  late bool _needsSetup = _controller.restored && !_controller.hasStoredPreference;

  @override
  void initState() {
    super.initState();
    if (!_controller.restored) _restore();
  }

  Future<void> _restore() async {
    await _controller.restore();
    if (mounted) {
      setState(() {
        _needsSetup = !_controller.hasStoredPreference;
        _ready = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const SizedBox.shrink();
    if (_needsSetup) {
      return LanguageSetupScreen(onDone: () => setState(() => _needsSetup = false));
    }
    return widget.child;
  }
}
