/// Whether a raw contact identifier is a phone number or an email
/// (Issue #542, acceptance criterion 3) — gates which dispatch
/// channels make sense for a given contact.
enum ContactIdentifierType { phone, email }
