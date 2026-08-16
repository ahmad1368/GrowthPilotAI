import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';

/// Local stand-in for the issue's NestJS `Video` collection (Issue #163)
/// — placeholder metadata until a real CMS/CDN is wired up; [AcademyVideo
/// .videoUrl]/[AcademyVideo.thumbnailUrl] values are placeholders, not
/// live links.
class AcademyVideoCatalog {
  static const List<AcademyVideo> all = [
    AcademyVideo(
      id: 'tax-tips-bc',
      title: 'Tax Tips for BC Small Businesses',
      thumbnailUrl: 'https://placeholder.growthpilot.ai/academy/tax-tips-bc.jpg',
      videoUrl: 'https://placeholder.growthpilot.ai/academy/tax-tips-bc',
      category: AcademyVideoCategory.legal,
      duration: Duration(minutes: 8, seconds: 40),
    ),
    AcademyVideo(
      id: 'marketplace-basics',
      title: 'Getting Started on the Marketplace',
      thumbnailUrl: 'https://placeholder.growthpilot.ai/academy/marketplace-basics.jpg',
      videoUrl: 'https://placeholder.growthpilot.ai/academy/marketplace-basics',
      category: AcademyVideoCategory.marketplace,
      duration: Duration(minutes: 5, seconds: 12),
    ),
    AcademyVideo(
      id: 'invoice-scanning-tutorial',
      title: 'How to Scan Invoices Like a Pro',
      thumbnailUrl: 'https://placeholder.growthpilot.ai/academy/invoice-scanning.jpg',
      videoUrl: 'https://placeholder.growthpilot.ai/academy/invoice-scanning',
      category: AcademyVideoCategory.tutorial,
      duration: Duration(minutes: 3, seconds: 55),
    ),
  ];
}
