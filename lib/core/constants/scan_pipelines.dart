import '../models/process_step.dart';
// ایمپورت پیج‌های مربوطه

class ScanPipelines {
  static final List<ProcessStep> docScanSteps = [
    ProcessStep(
      id: 'picking',
      title: 'انتخاب',
      order: 1,
      // navigateTo: (c) => const GalleryPage()
    ),
    ProcessStep(
      id: 'cropping',
      title: 'برش و تنظیم',
      order: 2,
    ),
    ProcessStep(
      id: 'finalizing',
      title: 'پردازش هوش مصنوعی',
      order: 3,
      weight: 3.0,
    ),
    ProcessStep(
      id: 'completed',
      title: 'اتمام عملیات',
      order: 4,
    ),
  ];
}
