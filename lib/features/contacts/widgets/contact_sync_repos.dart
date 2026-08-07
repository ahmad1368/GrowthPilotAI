import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/contact_sync_match_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/contact_sync_preference_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/registered_user_directory_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/contact_sync_match_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/contact_sync_preference_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/registered_user_directory_repository.dart';

/// Bundles the repositories the contact-sync feature needs (Issue
/// #541).
class ContactSyncRepos {
  final store = Get.find<ObjectBox>().store;

  late final directory =
      RegisteredUserDirectoryRepository(store.box<RegisteredUserDirectoryEntity>());
  late final matches = ContactSyncMatchRepository(store.box<ContactSyncMatchEntity>());
  late final preference =
      ContactSyncPreferenceRepository(store.box<ContactSyncPreferenceEntity>());
}
