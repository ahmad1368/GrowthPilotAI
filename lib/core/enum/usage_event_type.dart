/// A locally-logged in-app usage event (Issue #539's honest, local
/// reinterpretation of "tracking" — see PR notes). Everything here is
/// first-party and in-app only; nothing crosses to another app or site.
enum UsageEventType { appOpen, screenView, searchPerformed, actionCompleted }
