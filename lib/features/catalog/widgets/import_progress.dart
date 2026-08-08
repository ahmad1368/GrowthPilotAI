/// A snapshot of the bulk-import operation's progress (Issue #217) —
/// [etaSeconds] is derived from real measured throughput, not a
/// fabricated countdown.
typedef ImportProgress = ({String stage, int current, int total, double etaSeconds});
