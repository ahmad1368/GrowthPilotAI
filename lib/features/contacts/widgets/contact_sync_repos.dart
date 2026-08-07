import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/data/entities/contact_sync_match_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/contact_sync_preference_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/registered_user_directory_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/unmatched_contact_entity.dart';
import 'package:growth_pilot_ai/core/data/objectbox_provider.dart';
import 'package:growth_pilot_ai/core/data/repositories/contact_sync_match_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/contact_sync_preference_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/registered_user_directory_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/unmatched_contact_repository.dart';

/// Bundles the repositories the contact-sync feature needs (Issue
/// #541). [unmatchedContacts] persists non-registered contacts across
/// sessions for the referral engine (#542) to consume.
class ContactSyncRepos {
  final store = Get.find<ObjectBox>().store;

  late final directory =
      RegisteredUserDirectoryRepository(store.box<RegisteredUserDirectoryEntity>());
  late final matches = ContactSyncMatchRepository(store.box<ContactSyncMatchEntity>());
  late final preference =
      ContactSyncPreferenceRepository(store.box<ContactSyncPreferenceEntity>());
  late final unmatchedContacts =
      UnmatchedContactRepository(store.box<UnmatchedContactEntity>());
}
