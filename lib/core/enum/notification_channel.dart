/// Delivery channels the Notification Preference Center (Issue #158)
/// toggles per [NotificationCategory] — Push is the only channel this
/// offline-first client can actually gate locally today (Email/SMS are
/// server-dispatched); all three are modeled so the toggle grid matches
/// the issue's spec and future server integration.
enum NotificationChannel { push, email, sms }
