/// Post-send funnel stage for a dispatched alert (Issue #161) — "sent" is
/// implicit (the InboxNotificationEntity's own existence), so only the
/// stages after that get an explicit [NotificationConversionEventEntity].
enum ConversionStatus { opened, chatStarted, dealClosed }
