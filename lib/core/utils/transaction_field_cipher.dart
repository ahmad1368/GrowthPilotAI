import 'package:growth_pilot_ai/core/utils/field_cipher.dart';

/// [FieldCipher] scoped to transaction sensitive fields (Issue #262) —
/// its own independent key (`transaction_field_encryption_key_v1`, per
/// the issue's own `db_encryption_key_v1` naming) so rotating it never
/// touches the intelligence-cache or CRA-log ciphers ([FieldCipher]'s own
/// key-scoping design, from #106/#428).
class TransactionFieldCipher extends FieldCipher {
  TransactionFieldCipher() : super(keyStorageKey: 'transaction_field_encryption_key_v1');
}
