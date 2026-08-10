import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';

/// Records that a session was just used (Issue #173 AC: "Accurate
/// Tracking" of last-active time) — mutates in place, same style as
/// [RotateAuthSession]'s companions.
class TouchSessionActivity {
  static void call(AuthSessionEntity session, DateTime now) {
    session.lastActiveAt = now;
  }
}
