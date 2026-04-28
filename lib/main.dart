import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
// ایمپورت کردن ویجت‌ها و صفحات
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // دریافت آخرین وضعیت تم ذخیره شده از حافظه گوشی
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // ۱. تنظیمات تم روشن (Light) - شخصی‌سازی شده
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        // اضافه کردن تنظیمات فونت یا تم‌های خاص ویجت‌ها در اینجا
      ),

      // ۲. تنظیمات تم تاریک (Dark) - شخصی‌سازی شده
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),

      // اولویت با تم ذخیره شده است، در غیر این صورت از تم سیستم استفاده می‌کند
      initial: savedThemeMode ?? AdaptiveThemeMode.system,

      // ۳. سازنده MaterialApp که با پکیج AdaptiveTheme هماهنگ شده است
      builder: (theme, darkTheme) => MaterialApp(
        title: 'GrowthPilot AI',
        debugShowCheckedModeBanner: false,

        // این دو خط، تم‌های تعریف شده در بالا را به اپلیکیشن تزریق می‌کنند
        theme: theme,
        darkTheme: darkTheme,

        // تعیین صفحه اصلی
        home: const HomeLayout(),

        // ۴. جدول مسیرها
        routes: {
          '/settings': (context) => const SettingsScreen(),
        },
      ),
    );
  }
}
