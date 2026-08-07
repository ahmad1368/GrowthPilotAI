import 'package:growth_pilot_ai/business/hash_contact_identifier.dart';
import 'package:growth_pilot_ai/core/data/entities/registered_user_directory_entity.dart';
import 'package:growth_pilot_ai/core/data/registered_user_directory_seeds.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_repos.dart';

/// Populates the demo registered-user directory once, if empty (Issue
/// #541) — split out of [ContactSyncActions] to stay under the file
/// line cap.
void seedRegisteredUserDirectory(ContactSyncRepos repos) {
  if (repos.directory.getAll().isNotEmpty) return;
  final now = DateTime.now();
  for (final seed in registeredUserDirectorySeeds) {
    repos.directory.save(RegisteredUserDirectoryEntity(
      displayName: seed.name,
      hashedPhone: seed.phone == null ? '' : HashContactIdentifier.call(seed.phone!),
      hashedEmail: seed.email == null ? '' : HashContactIdentifier.call(seed.email!),
      addedAt: now,
    ));
  }
}
