/// "The primary persona or department affected" (Issue #229's own
/// `stakeholder` field) — a keyword heuristic, not an LLM judgment (see
/// PR notes): the first department/role name mentioned in the sentence,
/// or 'Unassigned' if none is. Always correctable via the AC's "Manual
/// Override" dropdown.
class GuessRequirementStakeholder {
  static const _knownStakeholders = [
    'customer',
    'administrator',
    'admin',
    'manager',
    'finance',
    'accounting',
    'it department',
    'sales',
    'support team',
    'compliance',
  ];

  /// Deduplicated options for the "Manual Override" dropdown (Issue
  /// #229).
  static const dropdownOptions = [
    'Unassigned',
    'Customer',
    'Administrator',
    'Manager',
    'Finance',
    'IT Department',
    'Sales',
    'Support Team',
    'Compliance',
  ];

  static String call(String sentence) {
    final lower = sentence.toLowerCase();
    for (final stakeholder in _knownStakeholders) {
      if (lower.contains(stakeholder)) return _titleCase(stakeholder);
    }
    return 'Unassigned';
  }

  static String _titleCase(String value) =>
      value.split(' ').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
}
