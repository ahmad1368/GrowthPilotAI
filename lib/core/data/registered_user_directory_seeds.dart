/// Demo "already registered" merchants for the contact-sync matching
/// simulation (Issue #541) — this app has no real backend/user base,
/// so these fixed identifiers let a tester paste the same value into
/// the sync box and see a genuine SHA-256 hash match end-to-end.
const registeredUserDirectorySeeds = [
  (name: 'Golden Spice Imports', phone: '+16045550101', email: null),
  (name: 'Pacific Coast Wholesale', phone: null, email: 'orders@pacificcoast.example'),
  (name: 'Maple Leaf Textiles', phone: '+16045550199', email: null),
];
