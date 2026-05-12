// lib/core/constants/app_pipelines.dart
import '../models/process_step.dart';

class AppPipelines {
  static final List<ProcessStep> scanSteps = [
    ProcessStep(
      id: 'source',
      title: 'انتخاب سند',
      order: 1,
      // navigateTo: (context) => const DocumentSourcePage(),
    ),
    ProcessStep(
      id: 'preview',
      title: 'پیش‌نمایش و اصلاح',
      order: 2,
      weight: 1.5,
    ),
    ProcessStep(
      id: 'ai_process',
      title: 'پردازش هوشمند',
      order: 3,
      weight: 3.0,
    ),
    ProcessStep(
      id: 'export',
      title: 'خروجی نهایی',
      order: 4,
    ),
  ];
}
