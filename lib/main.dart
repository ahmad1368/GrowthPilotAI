import 'dart:async';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/services/omni_logger.dart';
import 'package:growth_pilot_ai/widgets/global_error_view.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/bindings/app_bindings.dart';
import 'package:growth_pilot_ai/controllers/category_mapping_controller.dart';
import 'package:growth_pilot_ai/controllers/accounting_integrations_controller.dart';
import 'package:growth_pilot_ai/controllers/connected_accounts_controller.dart';
import 'package:growth_pilot_ai/controllers/transaction_match_controller.dart';
import 'package:growth_pilot_ai/controllers/inbox_controller.dart';
import 'package:growth_pilot_ai/controllers/business_compass_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/features/analytics/report_widgets_bootstrap.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/screens/forecast_screen.dart';
import 'package:growth_pilot_ai/features/analytics/screens/business_compass_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/connected_accounts_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/integrations_dashboard_screen.dart';
import 'package:growth_pilot_ai/features/transactions/screens/category_mapping_screen.dart';
import 'package:growth_pilot_ai/features/transactions/screens/duplicate_matches_screen.dart';
import 'package:growth_pilot_ai/features/inbox/screens/inbox_screen.dart';
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
    ReportWidgetsBootstrap.register();
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
      // [Issue #8] Cross-fades the whole app between light/dark instead of
      // the instant theme swap AdaptiveTheme does on its own.
      builder: (theme, darkTheme) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: GetMaterialApp(
          key: ValueKey(theme.brightness),
          title: 'GrowthPilot AI',
          debugShowCheckedModeBanner: false,
          initialBinding: AppBindings(),
          theme: theme,
          darkTheme: darkTheme,
          home: const HomeLayout(),
          getPages: [
            GetPage(name: '/settings', page: () => const SettingsScreen()),
            GetPage(name: '/forecast', page: () => const ForecastScreen()),
            GetPage(
              name: '/category-mapping',
              page: () => const CategoryMappingScreen(),
              binding: BindingsBuilder(
                () => Get.lazyPut(() => CategoryMappingController()),
              ),
            ),
            GetPage(
              name: '/settings/integrations',
              page: () => const IntegrationsDashboardScreen(),
              binding: BindingsBuilder(
                () => Get.lazyPut(() => AccountingIntegrationsController()),
              ),
            ),
            GetPage(
              name: '/settings/connected-accounts',
              page: () => const ConnectedAccountsScreen(),
              binding: BindingsBuilder(
                () => Get.lazyPut(() => ConnectedAccountsController()),
              ),
            ),
            GetPage(
              name: '/transactions/duplicates',
              page: () => const DuplicateMatchesScreen(),
              binding: BindingsBuilder(
                () => Get.lazyPut(() => TransactionMatchController()),
              ),
            ),
            GetPage(
              name: '/inbox',
              page: () => const InboxScreen(),
              binding: BindingsBuilder(
                () => Get.lazyPut(() => InboxController()),
              ),
            ),
            GetPage(
              name: '/business-compass',
              page: () => const BusinessCompassScreen(),
              binding: BindingsBuilder(() {
                Get.lazyPut(() => BusinessCompassController());
                Get.lazyPut(() => WidgetLayoutController(
                    DependencyInjection.get<WidgetLayoutStore>()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
