/// Granular, additive permission scopes (Issue #174) — replaces
/// per-feature bespoke role switches (e.g. [OrgActionGuard]'s hardcoded
/// owner/admin/buyer/vendor cases) with named scopes a membership can be
/// granted independently of its [MembershipRole].
enum Permission { viewReports, manageInventory, manageBilling, manageTeam, manageChat }
