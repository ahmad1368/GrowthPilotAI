import 'package:flutter/foundation.dart';

/// Authenticated user identity (the client-side analog of the backend's Mongo
/// UserSchema). Holds only essential profile data plus the Firebase uid.
@immutable
class AuthUser {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? displayName;

  const AuthUser({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
  });
}
