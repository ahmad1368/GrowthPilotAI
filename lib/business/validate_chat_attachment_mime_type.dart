/// "MIME Type Validation" (Issue #133 AC): only professional formats are
/// allowed in chat attachments; everything else — including executable
/// scripts — is blocked.
class ValidateChatAttachmentMimeType {
  static const allowed = {
    'application/pdf',
    'image/vnd.dwg',
    'image/png',
    'image/jpeg',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  };

  static bool call(String mimeType) => allowed.contains(mimeType);
}
