/// The kind of live disruption reported to OmniPulse (Issue #267/#268)
/// — enterprise B2B "traffic hazard" categories instead of consumer
/// road hazards.
enum PulseCategory { financialBlocker, operationalHazard, regulatoryUpdate }

extension PulseCategoryX on PulseCategory {
  String get label => switch (this) {
        PulseCategory.financialBlocker => 'Financial Blocker',
        PulseCategory.operationalHazard => 'Operational Hazard',
        PulseCategory.regulatoryUpdate => 'Regulatory Update',
      };
}
