import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/widgets/global_error_view.dart';

// Imports Core & Infrastructure
import 'core/bindings/app_bindings.dart';
import 'core/data/objectbox_provider.dart';
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';

import 'dart:async';
// ایمپورت‌های پروژه‌ی خودت را اینجا اضافه کن (OmniLogger, AppBindings, ObjectBox و غیره)

void main() {
  // تمام کدهایی که دارای await هستند یا ممکن است خطا بدهند را در این ناحیه امن قرار می‌دهیم
  runZonedGuarded(() async {
    // ۱. اطمینان از مقداردهی اولیه موتور فلاتر
    WidgetsFlutterBinding.ensureInitialized();

    // ۲. مدیریت خطاهای فریم‌ورک (UI Errors)
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      OmniLogger.error(
        title: "Flutter Framework Error",
        message: details.exception,
        stackTrace: details.stack,
      );
    };

    // اختصاصی‌سازی صفحه قرمز با استاندارد پروژه
    ErrorWidget.builder = (FlutterErrorDetails details) {
      // استفاده از ویجت جدید که بر پایه OmniGlassPanel است
      return GlobalErrorView(details: details);
    };

    // ۴. راه‌اندازی دیتابیس ObjectBox (قابلیت قبلی شما)
    final objectbox = await ObjectBox.create();
    Get.put<ObjectBox>(objectbox, permanent: true);

    // ۵. دریافت وضعیت تم (قابلیت قبلی شما)
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    // ۶. اجرای اپلیکیشن با استفاده از Bindings برای تزریق وابستگی‌ها
    runApp(MyApp(
      savedThemeMode: savedThemeMode,
    ));
  }, (Object error, StackTrace stack) {
    // ۷. توری نجات نهایی (Async Errors)
    // هر خطایی که در بالا catch نشود، اینجا شکار می‌شود
    OmniLogger.error(
      title: "GLOBAL UNCAUGHT EXCEPTION",
      message: error,
      stackTrace: stack,
    );

    // در اینجا می‌توانید لاگ را به سرور هم بفرستید
  });
}

// نکته در مورد MyApp:
// حتما در GetMaterialApp مقدار initialBinding: AppBindings() را قرار دهید.

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // --- Light Theme ---
      light: _buildLightTheme(),

      // --- Dark Theme ---
      dark: _buildDarkTheme(),

      initial: savedThemeMode ?? AdaptiveThemeMode.system,

      builder: (theme, darkTheme) {
        return GetMaterialApp(
          title: 'GrowthPilot AI',
          debugShowCheckedModeBanner: false,

          // استفاده از سیستم تزریق وابستگی مرکزی ما
          initialBinding: AppBindings(),

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

  // متدهای کمکی برای تمیز ماندن متد Build
  ThemeData _buildLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF7F8FA),
      useMaterial3: true,
      colorSchemeSeed: Colors.teal,
      elevatedButtonTheme: _buttonTheme(Colors.teal, Colors.white),
      appBarTheme: _appBarTheme(Colors.black),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      useMaterial3: true,
      colorSchemeSeed: Colors.tealAccent,
      elevatedButtonTheme:
          _buttonTheme(Colors.tealAccent.shade700, Colors.black),
      appBarTheme: _appBarTheme(Colors.white),
    );
  }

  ElevatedButtonThemeData _buttonTheme(Color bg, Color fg) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bg,
        foregroundColor: fg,
        minimumSize: const Size(100, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        textStyle: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, fontFamily: 'Vazir'),
      ),
    );
  }

  AppBarTheme _appBarTheme(Color contentColor) {
    return AppBarTheme(
      iconTheme: IconThemeData(color: contentColor),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    );
  }
}
