import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_screen.dart';
import 'package:growth_pilot_ai/widgets/global_error_view.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/bindings/app_bindings.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'widgets/home_layout.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      // OmniLogger.error(
      //     title: "Flutter Framework Error",
      //     message: details.exception,
      //     stackTrace: details.stack,
      //     widgetName: "main.dart");
      OmniLogger.error(
          message: "Flutter Framework Error",
          worker: "Main.dart",
          exception: details.exception,
          serviceName: "runZonedGuarded",
          stackTrace: details.stack);
    };

    ErrorWidget.builder = (details) => GlobalErrorView(details: details);

    final objectbox = await ObjectBox.create();
    Get.put<ObjectBox>(objectbox, permanent: true);

    await DependencyInjection.init();
    final savedThemeMode = await AdaptiveTheme.getThemeMode();

    runApp(MyApp(savedThemeMode: savedThemeMode));
  }, (Object error, StackTrace stack) {
    OmniLogger.error(
      message: "GLOBAL UNCAUGHT EXCEPTION: $error",
      worker: "Ahmad_Salem_Pour",
      serviceName: "main.dart",
      stackTrace: stack,
    );
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
          GetPage(name: '/settings', page: () => const SettingsScreen())
        ],
      ),
    );
  }
}
