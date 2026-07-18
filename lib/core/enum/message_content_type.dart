/// Shape of a single inbox message's body (Issue #70). [actionCard] carries
/// a structured [ActionCardData] payload instead of plain text (Issue #73).
enum MessageContentType { text, image, pdf, systemEvent, actionCard }
