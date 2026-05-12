import '../models/process_step.dart';
// ایمپورت پیج‌های مربوطه

class ScanPipelines {
  static final List<ProcessStep> docScanSteps = [
    ProcessStep(
      id: 'pick',
      title: 'انتخاب تصویر',
      order: 1,
      // navigateTo: (c) => const GalleryPage()
    ),
    ProcessStep(
      id: 'crop',
      title: 'برش و تنظیم',
      order: 2,
    ),
    ProcessStep(
      id: 'ai',
      title: 'پردازش هوش مصنوعی',
      order: 3,
      weight: 3.0,
    ),
    ProcessStep(
      id: 'done',
      title: 'اتمام عملیات',
      order: 4,
    ),
  ];
}
