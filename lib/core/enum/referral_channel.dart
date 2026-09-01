/// Dispatch channel for a referral invite (Issue #542, acceptance
/// criterion 3) — this app has no Twilio/SendGrid-style backend, so
/// [smsApi] and [emailApi] both open the device's own Messages/Mail
/// app pre-filled via `sms:`/`mailto:` intents rather than sending
/// through a real third-party API; the send action still requires the
/// user to tap Send themselves, which is what keeps every channel
/// here compliant with acceptance criterion 6.
enum ReferralChannel { smsApi, emailApi, shareSheet }
