/// Device hardware tier (Issue #110) — drives how aggressively background
/// work (the #105 cache sync, the #108 insight scan) throttles itself to
/// save battery/CPU on low-end hardware.
enum PerformanceTier { low, mid, high }
