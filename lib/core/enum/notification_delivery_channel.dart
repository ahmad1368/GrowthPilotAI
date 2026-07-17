/// Which channel(s) a dispatched notification actually goes out on
/// (Issue #71) — mirrors the dispatcher's Socket.io-vs-FCM decision.
enum NotificationDeliveryChannel { inApp, push }
