/// Local stand-in for NestJS gateway namespace partitioning (Issue #130:
/// `/chat`, `/market`, `/notifications`) — isolates which realtime feed a
/// connection belongs to without needing separate socket namespaces.
enum RealtimeNamespace { chat, market, notifications }
