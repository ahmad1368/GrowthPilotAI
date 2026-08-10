# Deterministic hashing (Issue #89)

`GenerateDeterministicHash` (`lib/business/generate_deterministic_hash.dart`)
is the shared utility for turning an identifier or object into a
deterministic, non-reversible hash — e.g. so a raw database ID is never
exposed directly in a URL, or so the matching engine (#145) and the
anonymization pipeline (#80/#88) can compare records without seeing the
underlying value.

## How it works

- **Canonicalization** (`CanonicalizeForHash`): strings pass through as-is;
  maps/lists are serialized with map keys sorted recursively, so two
  semantically identical objects built in a different key order (e.g. a
  different DB column projection, or spread/merge order) always produce the
  *same* canonical string, and therefore the same hash. Verify with
  `CanonicalizeForHash.call({'a': 1, 'b': 2}) == CanonicalizeForHash.call({'b': 2, 'a': 1})`.
- **Hashing**: HMAC-SHA256 keyed by a `HashPepper`, not raw
  `sha256(input + salt)` concatenation — HMAC is keyed by construction and
  resists length-extension attacks that raw concatenation does not.
- **Pepper**: `HashPepper` throws immediately if constructed with an empty
  value, rather than silently hashing with a missing/`"undefined"` pepper.

## Known limitation

This app has no backend distinct from the client (see the #120 session
model's own note on this). A pepper embedded in a client build is not a
real secret — anyone with the compiled app can extract it. This utility
provides the deterministic-hashing *algorithm* correctly; a deployment
that needs the pepper to be a genuine secret must compute these hashes
server-side instead.

## Out of scope for this PR

- Hash-collision flagging: SHA-256's collision probability is
  cryptographically negligible; no detection logic was added.
- `HASH_VERSION` migration/versioning strategy for rotating the pepper or
  algorithm later — left for whichever future issue first needs to change
  either.
