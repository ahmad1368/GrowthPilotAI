import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/widgets/global_error_view.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/bindings/app_bindings.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/screens/forecast_screen.dart';
import 'widgets/home_layout.dart';
import 'screens/settings_screen.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      OmniLogger.error(
          title: "Flutter Framework Error",
          message: details.exception,
          stackTrace: details.stack,
          widgetName: "main.dart");
    };

    ErrorWidget.builder = (details) => GlobalErrorView(details: details);

    final objectbox = await ObjectBox.create();
    Get.put<ObjectBox>(objectbox, permanent: true);

    await DependencyInjection.init();
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    runApp(MyApp(savedThemeMode: savedThemeMode));
  }, (Object error, StackTrace stack) {
    OmniLogger.error(
        title: "GLOBAL UNCAUGHT EXCEPTION",
        message: "$error | User: Ahmad_Salem_Pour",
        stackTrace: stack,
        widgetName: "main.dart");
  });
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.buildTheme(Brightness.light),
      dark: AppTheme.buildTheme(Brightness.dark),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => GetMaterialApp(
        title: 'GrowthPilot AI',
        debugShowCheckedModeBanner: false,
        initialBinding: AppBindings(),
        theme: theme,
        darkTheme: darkTheme,
        home: const HomeLayout(),
        getPages: [
          GetPage(name: '/settings', page: () => const SettingsScreen()),
          GetPage(name: '/forecast', page: () => const ForecastScreen()),
        ],
      ),
    );
  }
}
