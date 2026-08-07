import 'package:growth_pilot_ai/core/data/entities/registered_user_directory_entity.dart';
import 'package:growth_pilot_ai/core/models/contact_sync_result.dart';

/// Compares client-hashed contact identifiers against the pre-hashed
/// registered-user directory (Issue #541, acceptance criteria 3-4) —
/// only matched display names are ever returned; raw identifiers stay
/// client-side.
class MatchContactHashes {
  static ContactSyncResult call(
    Map<String, String> hashedByRawInput,
    List<RegisteredUserDirectoryEntity> directory,
  ) {
    final matchedNames = <String>[];
    final unmatched = <String>[];

    hashedByRawInput.forEach((raw, hash) {
      final match =
          directory.where((u) => u.hashedPhone == hash || u.hashedEmail == hash).firstOrNull;
      if (match != null) {
        matchedNames.add(match.displayName);
      } else {
        unmatched.add(raw);
      }
    });

    return ContactSyncResult(matchedNames: matchedNames, unmatchedIdentifiers: unmatched);
  }
}
