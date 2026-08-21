import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/deep_link_controller.dart';
import 'package:growth_pilot_ai/controllers/document_processing_orchestrator_controller.dart';
import 'package:growth_pilot_ai/controllers/founding_member_controller.dart';
import 'package:growth_pilot_ai/controllers/subscription_controller.dart';
import 'package:growth_pilot_ai/controllers/notification_attribution_controller.dart';
import 'package:growth_pilot_ai/controllers/notification_preference_controller.dart';
import 'package:growth_pilot_ai/controllers/performance_controller.dart';
import 'package:growth_pilot_ai/controllers/project_metrics_controller.dart';
import 'package:growth_pilot_ai/controllers/quiet_hours_controller.dart';
import 'package:growth_pilot_ai/controllers/requirement_triage_controller.dart';
import 'package:growth_pilot_ai/controllers/text_sanitization_controller.dart';
import 'package:growth_pilot_ai/controllers/traceability_controller.dart';
import 'package:growth_pilot_ai/core/di/dependency_injection.dart';
import 'package:growth_pilot_ai/core/data/repositories/project_metrics_snapshot_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_goal_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceable_requirement_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_test_case_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/requirement_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/suggested_link_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/export_event_repository.dart';
import 'package:growth_pilot_ai/core/services/ocr/ocr_service.dart';
import 'package:growth_pilot_ai/core/services/ocr/document_scanner_service.dart';
import 'package:growth_pilot_ai/core/services/ocr/document_text_extractor_service.dart';
import '../../services/connectivity_service.dart';
import '../../services/environment_service.dart';
import '../../services/scanner/scanner_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // سرویس‌های زیرساختی
    Get.lazyPut(() => EnvironmentService(), fenix: true);
    Get.lazyPut(() => ConnectivityService(), fenix: true);
    // Issue #110: تشخیص سطح سخت‌افزار + حالت صرفه‌جویی باتری
    Get.lazyPut(() => PerformanceController(), fenix: true);
    // Issue #158: مرکز تنظیمات اعلان‌ها (Push/Email/SMS در هر دسته)
    Get.lazyPut(() => NotificationPreferenceController(), fenix: true);
    // Issue #159: ساعات سکوت + سقف روزانه اعلان‌ها
    Get.lazyPut(() => QuietHoursController(), fenix: true);
    // Issue #161: نشست اسناد تبدیل اعلان (Last-Click, ۲۴ ساعته)
    Get.lazyPut(() => NotificationAttributionController(), fenix: true);
    // Issue #176: دریافت و مسیریابی Deep Link (growthpilotai://...)
    Get.lazyPut(() => DeepLinkController(), fenix: true);
    // Issue #191: برنامه Beta "Founding Member" (سهمیه ۱۰۰ نفر اول + فیدبک)
    Get.lazyPut(() => FoundingMemberController(), fenix: true);
    // Issue #171: صفحه محلی مدیریت اشتراک (جایگزین Stripe Customer Portal)
    Get.lazyPut(() => SubscriptionController(), fenix: true);

    // سرویس‌های پردازشی (که قبلاً با هم ساختیم)
    Get.lazyPut(() => OCRService(), fenix: true);
    Get.lazyPut(() => ScannerService(), fenix: true);
    // Issue #226/#227: اسکن مستندات کسب‌وکار (غیر از رسید) + OCR عمومی
    Get.lazyPut(() => DocumentScannerService(), fenix: true);
    Get.lazyPut(() => DocumentTextExtractorService(), fenix: true);

    // Issue #231-#234/#237: پایپلاین Requirement Triage + KPI Dashboard —
    // fenix:true تا صفحه‌ی Dashboard و صفحه‌ی Triage یک وضعیت مشترک ببینن
    Get.lazyPut(() => RequirementTriageController(), fenix: true);
    Get.lazyPut(() => TextSanitizationController(), fenix: true);
    Get.lazyPut(() => DocumentProcessingOrchestratorController(Get.find()), fenix: true);
    Get.lazyPut(
      () => ProjectMetricsController(DependencyInjection.get<ProjectMetricsSnapshotRepository>()),
      fenix: true,
    );
    // Issue #238/#242: ناوبر ردیابی الزامات — fenix:true تا لینک‌کردن از
    // صفحه‌ی Triage بلافاصله در صفحه‌ی Traceability Navigator دیده بشه
    Get.lazyPut(
      () => TraceabilityController(
        DependencyInjection.get<BusinessGoalRepository>(),
        DependencyInjection.get<TraceableRequirementRepository>(),
        DependencyInjection.get<TraceabilityTestCaseRepository>(),
        DependencyInjection.get<TraceabilityLinkRepository>(),
        DependencyInjection.get<RequirementHistoryRepository>(),
        DependencyInjection.get<SuggestedLinkRepository>(),
        DependencyInjection.get<ExportEventRepository>(),
      ),
      fenix: true,
    );
  }
}
