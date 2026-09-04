import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/login_controller.dart';
import 'package:growth_pilot_ai/features/auth/screens/login_screen.dart';

/// [Issue #786] Gates the app behind a local login screen. There is no
/// backend, so this is a UI access gate ([LoginController]/
/// [ValidateLocalLogin]), not real multi-user authentication. Mirrors
/// LegalConsentGate/OnboardingTourGate's restore-then-gate pattern.
class LoginGate extends StatefulWidget {
  final Widget child;
  const LoginGate({super.key, required this.child});

  @override
  State<LoginGate> createState() => _LoginGateState();
}

class _LoginGateState extends State<LoginGate> {
  final _controller = Get.put(LoginController(), permanent: true);
  bool _ready = false;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    await _controller.restore();
    if (mounted) setState(() => _ready = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!_ready) return const SizedBox.shrink();
    if (!_controller.isLoggedIn) {
      return LoginScreen(onLoggedIn: () => setState(() {}));
    }
    return widget.child;
  }
}
