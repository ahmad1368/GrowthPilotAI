import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/seed_app_preview_demo_data.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/unified_transaction_repository.dart';

/// Debug-only "camera ready" toggle for recording App Preview footage
/// (Issue #195): seeds clean mock data and suppresses in-app notification
/// banners (see [RichNotificationBanner]) while enabled. Does not touch
/// pre-existing real data — only adds one demo transaction.
class PresentationModeService extends GetxService {
  final isEnabled = false.obs;
  late UnifiedTransactionRepository _transactions;

  @override
  void onInit() {
    super.onInit();
    _transactions = UnifiedTransactionRepository(Get.find<ObjectBox>().store.box());
  }

  void toggle(bool value) {
    isEnabled.value = value;
    if (value) _transactions.upsert(SeedAppPreviewDemoData.call());
  }
}
