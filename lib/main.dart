import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart'; // اضافه شدن GetX برای مدیریت وضعیت
import 'package:growth_pilot_ai/services/connectivity_service.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';
import 'core/data/objectbox_provider.dart';

// تعریف متغیر سراسری برای دسترسی به دیتابیس در کل اپلیکیشن
late ObjectBox objectbox;

void main() async {
  // اطمینان از مقداردهی اولیه فلاتر
  WidgetsFlutterBinding.ensureInitialized();

  // ۱. راه‌اندازی دیتابیس قبل از شروع رابط کاربری
  objectbox = await ObjectBox.create();

  // ۲. دریافت تم ذخیره شده از حافظه
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  Get.put(EnvironmentService()); // این خط حتماً باید باشد
  Get.put(ConnectivityService());
  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        // استفاده از GetMaterialApp به جای MaterialApp برای فعالسازی قابلیت‌های GetX
        return GetMaterialApp(
          title: 'GrowthPilot AI',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,

          // مدیریت مسیرها (Routing) با GetX
          home: const HomeLayout(),
          getPages: [
            GetPage(name: '/settings', page: () => const SettingsScreen()),
          ],

          // حفظ انیمیشن تعویض تم که قبلاً داشتی
          builder: (context, child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: Container(
                key: ValueKey(theme.brightness),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}
