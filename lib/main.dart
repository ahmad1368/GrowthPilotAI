import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
// ایمپورت کردن ویجت‌ها و صفحات
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // دریافت آخرین وضعیت تم ذخیره شده (اگر وجود داشته باشد)
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // ۱. تنظیمات تم روشن (Light)
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // پس‌زمینه روشن و ملایم
      ),
      
      // ۲. تنظیمات تم تاریک (Dark)
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // پس‌زمینه تیره عمیق
      ),
      
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      
      // ۳. سازنده اصلی MaterialApp
      builder: (theme, darkTheme) => MaterialApp(
        title: 'GrowthPilot AI',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        
        // تعیین صفحه اصلی (Home)
        home: const HomeLayout(),

        // ۴. تعریف جدول مسیرها (برای جلوگیری از خطای Route Error)
        routes: {
          '/settings': (context) => const SettingsScreen(),
          // اگر در آینده صفحات دیگری مثل پروفایل اضافه کردی، اینجا تعریف کن:
          // '/profile': (context) => const ProfileScreen(),
        },
      ),
    );
  }
}