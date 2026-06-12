import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  const AppDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final txtColor = isDark ? const Color(0xffffffff) : const Color(0xff18181b);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: const Color(0xff2563eb),
          child: Icon(Icons.person, size: 50, color: txtColor),
        ),
        const SizedBox(height: 15),
        Text(
          "Ahmad",
          // 💡 استفاده از تیتر نیتیو فلاتر جهت جلوگیری از کرش کانتکست تم‌های فرعی
          style: (textTheme.titleLarge ?? const TextStyle()).copyWith(
            color: txtColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Developer",
          // 💡 استفاده از استایل بدنه ثانویه و اعمال لایه شفافیت به صورت کاملاً امن
          style: (textTheme.bodyMedium ?? const TextStyle()).copyWith(
            color: txtColor.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
