import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/features/security/presentation/widgets/security_feature_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SecurityStatusPage extends StatelessWidget {
  const SecurityStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xff09090b) : const Color(0xffffffff),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: ShadCard(
            backgroundColor:
                isDark ? const Color(0xff18181b) : const Color(0xffffffff),
            padding: const EdgeInsets.all(24.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_person_rounded,
                    size: 64,
                    color: isDark
                        ? const Color(0xff22c55e)
                        : const Color(0xff16a34a)),
                const SizedBox(height: 16),
                Text('دیتابیس با استاندارد AES-256 رمزنگاری شد',
                    style: theme.textTheme.h4, textAlign: TextAlign.center),
                const Divider(height: 40, color: Color(0xff27272a)),
                const SecurityFeatureRow(
                    icon: Icons.vpn_key_rounded,
                    title: 'کلید سخت‌افزاری',
                    subtitle: 'ذخیره شده در Secure Storage سخت‌افزاری'),
                const SecurityFeatureRow(
                    icon: Icons.verified_user_rounded,
                    title: 'انطباق با PIPEDA',
                    subtitle: 'استاندارد حفاظت از حریم خصوصی کانادا'),
                const SecurityFeatureRow(
                    icon: Icons.phonelink_lock_rounded,
                    title: 'محافظت بیومتریک',
                    subtitle: 'دسترسی محدود به صاحب دستگاه'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
