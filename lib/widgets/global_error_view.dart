import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GlobalErrorView extends StatelessWidget {
  final FlutterErrorDetails details;

  const GlobalErrorView({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    // راهکار امن: استفاده از تم نیتیو فلاتر یا خواندن مستقیم تم پلتفرم برای جلوگیری از ارور Null Check
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // انتخاب رنگ‌های مسطح بر اساس تم جاری بدون اتکا به روت ShadTheme
    final bgColor = isDark ? const Color(0xff09090b) : const Color(0xffffffff);
    final cardBg = isDark ? const Color(0xff18181b) : const Color(0xfff4f4f5);
    final borderColor =
        isDark ? const Color(0xff27272a) : const Color(0xffe4e4e7);
    final textPrimary =
        isDark ? const Color(0xffffffff) : const Color(0xff09090b);

    return Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardBg,
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.redAccent, size: 28),
                    const SizedBox(width: 12),
                    Text(
                      "خطای سیستمی در GrowthPilot",
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  // اعمال محدودیت حداکثر ارتفاع به صورت استاندارد
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: isDark
                      ? const Color(0xff09090b)
                      : const Color(0xffe4e4e7),
                  child: SingleChildScrollView(
                    child: Text(
                      details.exceptionAsString(),
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
