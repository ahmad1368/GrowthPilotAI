/// Lifecycle status of a tracked physical asset (Issue #157). Only
/// [active] assets may have custody transferred between team members.
enum AssetCustodyStatus { active, underMaintenance, retired }
