/// Whether a buyer's first purchase falls inside the recent acquisition
/// window or predates it (Issue #394), for the CLV cohort trend.
enum CustomerCohort {
  newCustomer,
  established;

  String get label => switch (this) {
        CustomerCohort.newCustomer => 'New',
        CustomerCohort.established => 'Established',
      };
}
