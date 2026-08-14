import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';

/// Bridges the in-app Push toggle to the OS-level permission (Issue
/// #158 AC: "deep-link to System Settings" when push is blocked
/// natively). Web has no OS notification-permission concept in this
/// app, so it always reports "not blocked" rather than calling a
/// native-only plugin path.
class PushPermissionService {
  static Future<bool> isBlocked() async {
    if (kIsWeb) return false;
    final status = await Permission.notification.status;
    return status.isDenied || status.isPermanentlyDenied;
  }

  static Future<void> openSystemSettings() async {
    if (kIsWeb) return;
    await openAppSettings();
  }
}
