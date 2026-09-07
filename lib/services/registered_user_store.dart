import 'dart:convert';
import 'package:growth_pilot_ai/services/secure_storage_service.dart';

/// [Issue #788] Persists locally-registered accounts (email -> password
/// hash) as a single JSON blob in secure storage, alongside the fixed
/// demo account from Issue #786. Never stores a raw password — callers
/// must hash it first (see `HashPassword`).
class RegisteredUserStore {
  static const _storageKey = 'registered_users';

  static Future<Map<String, String>> _readAll() async {
    final raw = await SecureStorageService.readData(_storageKey);
    if (raw == null || raw.isEmpty) return {};
    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return decoded.map((key, value) => MapEntry(key, value as String));
  }

  static Future<bool> exists(String email) async {
    final users = await _readAll();
    return users.containsKey(email.trim().toLowerCase());
  }

  static Future<void> save(String email, String passwordHash) async {
    final users = await _readAll();
    users[email.trim().toLowerCase()] = passwordHash;
    await SecureStorageService.writeData(_storageKey, jsonEncode(users));
  }

  static Future<String?> passwordHashOf(String email) async {
    final users = await _readAll();
    return users[email.trim().toLowerCase()];
  }
}
