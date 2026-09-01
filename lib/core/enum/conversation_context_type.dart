/// What a conversation's contextual link points to, if anything (Issue #70)
/// — mirrors the `context.refType` field from the issue's MongoDB schema.
enum ConversationContextType { none, transaction, order, lead }
