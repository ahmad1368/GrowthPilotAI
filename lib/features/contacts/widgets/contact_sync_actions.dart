import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:growth_pilot_ai/business/hash_contact_identifier.dart';
import 'package:growth_pilot_ai/business/match_contact_hashes.dart';
import 'package:growth_pilot_ai/core/data/entities/contact_sync_match_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/unmatched_contact_entity.dart';
import 'package:growth_pilot_ai/core/models/contact_sync_result.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/contact_sync_repos.dart';
import 'package:growth_pilot_ai/features/contacts/widgets/seed_registered_user_directory.dart';

/// Permission request, hashing/matching orchestration, and privacy
/// controls for contact sync (Issue #541, acceptance criteria 1-5) —
/// split out of [ContactSyncBody].
class ContactSyncActions {
  final ContactSyncRepos repos;

  ContactSyncActions(this.repos);

  /// Android/iOS show the real OS contacts permission prompt; this app
  /// has no native contact-reading plugin, so web (and any denied
  /// grant) falls through to the manual paste flow instead of failing.
  Future<bool> requestPermission() async {
    if (kIsWeb) return true;
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  ContactSyncResult sync(String pastedContacts) {
    seedRegisteredUserDirectory(repos);
    final lines = pastedContacts.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty);
    final hashedByRaw = {for (final line in lines) line: HashContactIdentifier.call(line)};
    final result = MatchContactHashes.call(hashedByRaw, repos.directory.getAll());
    for (final name in result.matchedNames) {
      repos.matches.save(ContactSyncMatchEntity(matchedUserName: name, matchedAt: DateTime.now()));
    }
    for (final contact in result.unmatchedIdentifiers) {
      if (!repos.unmatchedContacts.exists(contact)) {
        repos.unmatchedContacts
            .save(UnmatchedContactEntity(rawIdentifier: contact, firstSeenAt: DateTime.now()));
      }
    }
    return result;
  }

  void setEnabled(bool enabled) {
    repos.preference.setEnabled(enabled);
    if (!enabled) repos.matches.clearAll();
  }
}
