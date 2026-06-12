import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // اضافه شدن ایمپورت شادسی‌ان

class SecurityFeatureRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SecurityFeatureRow({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: isDark ? const Color(0xff3b82f6) : const Color(0xff2563eb),
            size: 28,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      theme.textTheme.p.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: theme.textTheme.muted.copyWith(fontSize: 11),
                ),
              ],
            ), // جابه‌جایی و بسته‌شدن درست پرانتز کالم و اکسپندد در اینجا
          ),
        ],
      ),
    );
  }
}
