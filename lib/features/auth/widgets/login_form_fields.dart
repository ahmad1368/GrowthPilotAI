import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/login_controller.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

/// [Issue #786] Icon-led email/password fields plus the inline error
/// message, split out of [LoginScreen] to keep it under the file's SRP
/// line budget.
class LoginFormFields extends StatelessWidget {
  final LoginController controller;
  const LoginFormFields({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        TextFormField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_rounded),
            labelText: 'Email',
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.lock_rounded),
            labelText: 'Password',
          ),
          validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
        ),
        Obx(() {
          final message = controller.errorMessage.value;
          if (message == null) return const SizedBox(height: 8);
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(Icons.error_rounded,
                    size: 16, color: AppDesignTokens.error(theme.brightness)),
                const SizedBox(width: 6),
                Text(message,
                    style: TextStyle(color: AppDesignTokens.error(theme.brightness))),
              ],
            ),
          );
        }),
      ],
    );
  }
}
