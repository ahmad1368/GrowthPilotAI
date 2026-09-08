import 'package:get/get.dart';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// [Issue #826] Persists profile fields via SecureStorageService, mirroring
/// LocaleController's existing pattern — plain key/value fields don't need
/// a new ObjectBox entity.
class ProfileController extends GetxController {
  static const _nameKey = 'profile_display_name';
  static const _birthDateKey = 'profile_birth_date';
  static const _categoryKey = 'profile_business_category_id';
  static const _subcategoryKey = 'profile_business_subcategory_id';

  final RxString displayName = ''.obs;
  final Rx<DateTime?> birthDate = Rx<DateTime?>(null);
  final RxString businessCategoryId = ''.obs;
  final RxString businessSubcategoryId = ''.obs;
  bool loaded = false;

  Future<void> load() async {
    displayName.value = await SecureStorageService.readData(_nameKey) ?? '';
    final storedDate = await SecureStorageService.readData(_birthDateKey);
    birthDate.value = storedDate != null ? DateTime.tryParse(storedDate) : null;
    businessCategoryId.value = await SecureStorageService.readData(_categoryKey) ?? '';
    businessSubcategoryId.value = await SecureStorageService.readData(_subcategoryKey) ?? '';
    loaded = true;
  }

  Future<void> save() async {
    await SecureStorageService.writeData(_nameKey, displayName.value);
    if (birthDate.value != null) {
      await SecureStorageService.writeData(_birthDateKey, birthDate.value!.toIso8601String());
    }
    await SecureStorageService.writeData(_categoryKey, businessCategoryId.value);
    await SecureStorageService.writeData(_subcategoryKey, businessSubcategoryId.value);
  }

  void selectCategory(String categoryId) {
    businessCategoryId.value = categoryId;
    businessSubcategoryId.value = ''; // reset child when parent changes
  }
}
