import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/controllers/login_controller.dart';
import 'package:growth_pilot_ai/controllers/register_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/features/auth/widgets/login_form_fields.dart';
import 'package:growth_pilot_ai/features/auth/widgets/register_form_fields.dart';

/// [Issue #786] Local login gate screen. In debug builds its fields are
/// pre-filled with the trusted demo account ([LoginController]), so only
/// pressing "Login" is needed; release builds start empty.
///
/// [Issue #788] Also toggles in-place to a registration view
/// ([RegisterController]/[RegisterFormFields]) so a user can create their
/// own local account without leaving the auth flow.
class LoginScreen extends StatefulWidget {
  final VoidCallback onLoggedIn;
  const LoginScreen({super.key, required this.onLoggedIn});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = Get.find<LoginController>();
  final _registerController = Get.put(RegisterController());
  final _formKey = GlobalKey<FormState>();
  bool _showRegister = false;

  @override
  void dispose() {
    Get.delete<RegisterController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppDesignTokens.background(theme.brightness),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_person_rounded,
                      size: 48, color: AppDesignTokens.primary(theme.brightness)),
                  const SizedBox(height: 16),
                  Text(
                    _showRegister
                        ? 'Create your GrowthPilot AI account'
                        : 'Sign in to GrowthPilot AI',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 24),
                  _showRegister
                      ? RegisterFormFields(controller: _registerController)
                      : LoginFormFields(controller: _controller),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ShadButton(
                      onPressed: _showRegister ? _submitRegister : _submit,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(_showRegister ? Icons.person_add_rounded : Icons.login_rounded,
                              size: 18),
                          const SizedBox(width: 8),
                          Text(_showRegister ? 'Register' : 'Login'),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: _toggleMode,
                    child: Text(
                      _showRegister
                          ? 'Already have an account? Login'
                          : "Don't have an account? Register",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleMode() {
    _controller.errorMessage.value = null;
    _registerController.errorMessage.value = null;
    setState(() => _showRegister = !_showRegister);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await _controller.login();
    if (success) widget.onLoggedIn();
  }

  Future<void> _submitRegister() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await _registerController.register();
    if (success) widget.onLoggedIn();
  }
}
