import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:growth_pilot_ai/business/build_continue_watching_list.dart';
import 'package:growth_pilot_ai/business/deserialize_watch_events.dart';
import 'package:growth_pilot_ai/business/filter_videos_by_category.dart';
import 'package:growth_pilot_ai/business/serialize_watch_events.dart';
import 'package:growth_pilot_ai/core/data/datasources/academy_video_catalog.dart';
import 'package:growth_pilot_ai/core/enum/academy_video_category.dart';
import 'package:growth_pilot_ai/core/models/academy_video.dart';
import 'package:growth_pilot_ai/core/models/watch_event.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Owns Business Academy browsing + local watch history (Issue #163).
class AcademyController extends GetxController {
  static const _storageKey = 'academy_watch_events';

  final Rx<AcademyVideoCategory?> selectedCategory = Rx(null);
  final RxList<WatchEvent> _events = <WatchEvent>[].obs;

  List<AcademyVideo> get visibleVideos =>
      FilterVideosByCategory.call(AcademyVideoCatalog.all, selectedCategory.value);

  List<AcademyVideo> get continueWatching =>
      BuildContinueWatchingList.call(AcademyVideoCatalog.all, _events);

  @override
  void onInit() {
    super.onInit();
    SecureStorageService.readData(_storageKey)
        .then((stored) => _events.assignAll(DeserializeWatchEvents.call(stored)));
  }

  Future<void> openVideo(AcademyVideo video) async {
    _events.removeWhere((e) => e.videoId == video.id);
    _events.add(WatchEvent(videoId: video.id, openedAt: DateTime.now()));
    await SecureStorageService.writeData(_storageKey, SerializeWatchEvents.call(_events));
    await launchUrl(Uri.parse(video.videoUrl), mode: LaunchMode.externalApplication);
  }
}
