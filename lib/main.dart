import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/controllers/dashboard_export_controller.dart';
import 'package:growth_pilot_ai/controllers/dashboard_template_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/features/analytics/report_widgets_bootstrap.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/screens/forecast_screen.dart';
import 'package:growth_pilot_ai/features/analytics/screens/business_compass_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/billing_settings_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/analytics_dashboard_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/branding_settings_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/support_chat_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/connected_accounts_screen.dart';
import 'package:growth_pilot_ai/features/settings/screens/integrations_dashboard_screen.dart';
import 'package:growth_pilot_ai/controllers/branding_settings_controller.dart';
import 'package:growth_pilot_ai/features/transactions/screens/category_mapping_screen.dart';
import 'package:growth_pilot_ai/features/transactions/screens/duplicate_matches_screen.dart';
import 'package:growth_pilot_ai/features/inbox/screens/inbox_screen.dart';
import 'package:growth_pilot_ai/features/academy/screens/academy_screen.dart';
import 'package:growth_pilot_ai/features/ai_engine/screens/ai_engine_screen.dart';
import 'package:growth_pilot_ai/features/graph/screens/requirement_triage_screen.dart';
import 'package:growth_pilot_ai/features/graph/screens/kpi_dashboard_screen.dart';
import 'package:growth_pilot_ai/controllers/kpi_dashboard_export_controller.dart';
import 'package:growth_pilot_ai/features/graph/screens/traceability_navigator_screen.dart';
import 'package:growth_pilot_ai/features/graph/screens/traceability_matrix_screen.dart';
import 'package:growth_pilot_ai/features/graph/screens/traceability_report_preview_screen.dart';
import 'package:growth_pilot_ai/features/graph/screens/export_history_screen.dart';
import 'package:growth_pilot_ai/controllers/export_history_controller.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/routes/module_access_middleware.dart';
import 'package:growth_pilot_ai/core/i18n/app_translations.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/app_locale_gate.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/onboarding_tour_gate.dart';
import 'package:growth_pilot_ai/features/ai_chat/widgets/ai_chat_root_overlay.dart';
import 'package:growth_pilot_ai/core/widgets/connectivity_gate.dart';
import 'package:growth_pilot_ai/core/widgets/deep_link_gate.dart';
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
    ReportWidgetsBootstrap.registerConfig();
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
          translations: AppTranslations(),
          locale: const Locale('en'),
          fallbackLocale: const Locale('en'),
          supportedLocales: AppLocale.values.map((l) => Locale(l.languageCode)),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const AppLocaleGate(
              child: OnboardingTourGate(
                  child: ConnectivityGate(
                      child: DeepLinkGate(
                          child: AiChatRootOverlay(child: HomeLayout()))))),
          getPages: [
            GetPage(
              name: '/settings',
              page: () => const SettingsScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/academy',
              page: () => const AcademyScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/ai-engine',
              page: () => const AiEngineScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/forecast',
              page: () => const ForecastScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/category-mapping',
              page: () => const CategoryMappingScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => CategoryMappingController()),
              ),
            ),
            GetPage(
              name: '/settings/integrations',
              page: () => const IntegrationsDashboardScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => AccountingIntegrationsController()),
              ),
            ),
            GetPage(
              name: '/settings/billing',
              page: () => const BillingSettingsScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/settings/support',
              page: () => const SupportChatScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/settings/analytics',
              page: () => const AnalyticsDashboardScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/settings/branding',
              page: () => const BrandingSettingsScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => BrandingSettingsController()),
              ),
            ),
            GetPage(
              name: '/settings/connected-accounts',
              page: () => const ConnectedAccountsScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => ConnectedAccountsController()),
              ),
            ),
            GetPage(
              name: '/transactions/duplicates',
              page: () => const DuplicateMatchesScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => TransactionMatchController()),
              ),
            ),
            GetPage(
              name: '/inbox',
              page: () => const InboxScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => InboxController()),
              ),
            ),
            GetPage(
              name: '/requirements/triage',
              page: () => const RequirementTriageScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/requirements/dashboard',
              page: () => const KpiDashboardScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(() => KpiDashboardExportController()),
              ),
            ),
            GetPage(
              name: '/requirements/traceability',
              page: () => const TraceabilityNavigatorScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/requirements/traceability/matrix',
              page: () => const TraceabilityMatrixScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/requirements/traceability/report-preview',
              page: () => const TraceabilityReportPreviewScreen(),
              middlewares: [ModuleAccessMiddleware()],
            ),
            GetPage(
              name: '/requirements/traceability/export-history',
              page: () => const ExportHistoryScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(
                () => Get.lazyPut(
                  () => ExportHistoryController(DependencyInjection.get<ExportEventRepository>()),
                ),
              ),
            ),
            GetPage(
              name: '/business-compass',
              page: () => const BusinessCompassScreen(),
              middlewares: [ModuleAccessMiddleware()],
              binding: BindingsBuilder(() {
                Get.lazyPut(() => BusinessCompassController());
                Get.lazyPut(() => WidgetLayoutController(
                    DependencyInjection.get<WidgetLayoutStore>()));
                Get.lazyPut(() => WidgetConfigController(
                    DependencyInjection.get<WidgetConfigStore>()));
                Get.lazyPut(() =>
                    WidgetPreviewController(Get.find<WidgetConfigController>()));
                Get.lazyPut(() => DashboardExportController(
                    DependencyInjection.get<DashboardExportService>()));
                Get.lazyPut(() => DashboardTemplateController(
                    Get.find<WidgetLayoutController>(),
                    DependencyInjection.get<DashboardTemplateStore>()));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
