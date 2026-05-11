import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/connectivity_service.dart';
import 'package:growth_pilot_ai/services/environment_service.dart';
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';
import 'core/data/objectbox_provider.dart';

// تعریف متغیر سراسری برای دیتابیس
late ObjectBox objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ۱. راه‌اندازی دیتابیس
  objectbox = await ObjectBox.create();

  // ۲. دریافت تم ذخیره شده از حافظه
  final savedThemeMode = await AdaptiveTheme.getThemeMode();

  // ۳. تزریق سرویس‌های مورد نیاز
  Get.put(EnvironmentService());
  Get.put(ConnectivityService());

  runApp(MyApp(savedThemeMode: savedThemeMode));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // ---------------------------------------------------------
      // تنظیمات تم روشن (Light Theme)
      // ---------------------------------------------------------
      light: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        useMaterial3: true,

        // استایل سراسری دکمه‌های اصلی
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white, // رنگ متن و آیکون داخل دکمه
            minimumSize: const Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Vazir', // اگر فونت فارسی دارید اینجا ست کنید
            ),
          ),
        ),

        // مدیریت هوشمند آیکون‌های عادی در لایت‌مد
        iconTheme: const IconThemeData(color: Colors.black, size: 24),

        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        colorSchemeSeed: Colors.teal,
      ),

      // ---------------------------------------------------------
      // تنظیمات تم تاریک (Dark Theme)
      // ---------------------------------------------------------
      dark: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        useMaterial3: true,

        // استایل سراسری دکمه‌ها در دارک‌مد
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.tealAccent.shade700,
            foregroundColor: Colors.black, // کنتراست بهتر روی رنگ روشن
            minimumSize: const Size(100, 45),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            textStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),

        // مدیریت هوشمند آیکون‌های عادی در دارک‌مد
        iconTheme: const IconThemeData(color: Colors.white, size: 24),

        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        colorSchemeSeed: Colors.tealAccent,
      ),

      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return GetMaterialApp(
          title: 'GrowthPilot AI',
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,

          home: const HomeLayout(),
          getPages: [
            GetPage(name: '/settings', page: () => const SettingsScreen()),
          ],

          // انیمیشن نرم تعویض تم
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
