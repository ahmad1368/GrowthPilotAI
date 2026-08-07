import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/hash_contact_identifier.dart';
import 'package:growth_pilot_ai/business/match_contact_hashes.dart';
import 'package:growth_pilot_ai/core/data/entities/registered_user_directory_entity.dart';

void main() {
  test('matches a contact whose hash is in the directory', () {
    final hash = HashContactIdentifier.call('merchant@example.com');
    final directory = [
      RegisteredUserDirectoryEntity(
          displayName: 'Alpha Co', hashedEmail: hash, addedAt: DateTime(2026, 1, 1)),
    ];
    final result = MatchContactHashes.call(
        {'merchant@example.com': hash}, directory);
    expect(result.matchedNames, ['Alpha Co']);
    expect(result.unmatchedIdentifiers, isEmpty);
  });

  test('reports unmatched contacts without exposing raw directory data', () {
    final result = MatchContactHashes.call({'nobody@example.com': 'deadbeef'}, const []);
    expect(result.matchedNames, isEmpty);
    expect(result.unmatchedIdentifiers, ['nobody@example.com']);
  });
}
