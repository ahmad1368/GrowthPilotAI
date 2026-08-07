import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// Real AES-256 field-level encryption for sensitive compliance data
/// (Issue #428, acceptance criterion 3) — the key lives in the OS
/// secure enclave via [SecureStorageService], not in the ObjectBox
/// database itself, since the free/Community ObjectBox edition this
/// app uses has no native encryption-at-rest option (see
/// `db_status_panel.dart`'s honest disclosure of that limitation).
/// A fresh random IV is generated per call and stored alongside the
/// ciphertext, so encrypting the same plaintext twice never produces
/// the same output.
class FieldCipher {
  static const _keyStorageKey = 'cra_field_encryption_key';

  Future<enc.Encrypter> _encrypter() async {
    var keyBase64 = await SecureStorageService.readData(_keyStorageKey);
    if (keyBase64 == null) {
      keyBase64 = base64Encode(enc.Key.fromSecureRandom(32).bytes);
      await SecureStorageService.writeData(_keyStorageKey, keyBase64);
    }
    return enc.Encrypter(enc.AES(enc.Key(base64Decode(keyBase64))));
  }

  Future<String> encryptField(String plaintext) async {
    final encrypter = await _encrypter();
    final iv = enc.IV.fromSecureRandom(16);
    final encrypted = encrypter.encrypt(plaintext, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  Future<String> decryptField(String cipherText) async {
    final encrypter = await _encrypter();
    final parts = cipherText.split(':');
    return encrypter.decrypt64(parts[1], iv: enc.IV.fromBase64(parts[0]));
  }
}
