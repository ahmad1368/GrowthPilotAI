import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/enum/customer_cohort.dart';
import 'package:growth_pilot_ai/core/models/customer_lifetime_value.dart';
import 'package:growth_pilot_ai/core/models/customer_revenue_group.dart';

/// Per-buyer projected CLV (Issue #394): avg purchase value x purchase
/// frequency x a fixed projected lifespan, since this app has no churn
/// model to project a real per-customer lifespan from.
class ComputeCustomerLifetimeValues {
  static const projectedLifespanMonths = 36.0;
  static const newCohortWindowDays = 90;

  static List<CustomerLifetimeValue> call(
    List<TransactionEntity> transactions,
    DateTime now,
  ) {
    final groups = GroupTransactionsByCustomer.call(transactions);
    return [for (final g in groups) _toClv(g, now)]
      ..sort((a, b) => b.lifetimeValue.compareTo(a.lifetimeValue));
  }

  static CustomerLifetimeValue _toClv(CustomerRevenueGroup g, DateTime now) {
    final averagePurchaseValue = g.totalRevenue / g.transactionCount;
    final tenureDays = now.difference(g.firstPurchaseDate).inDays;
    final tenureMonths = (tenureDays / 30).clamp(1.0, double.infinity);
    final purchaseFrequencyPerMonth = g.transactionCount / tenureMonths;

    return CustomerLifetimeValue(
      label: g.label,
      averagePurchaseValue: averagePurchaseValue,
      purchaseFrequencyPerMonth: purchaseFrequencyPerMonth,
      projectedLifespanMonths: projectedLifespanMonths,
      lifetimeValue: averagePurchaseValue *
          purchaseFrequencyPerMonth *
          projectedLifespanMonths,
      cohort: tenureDays <= newCohortWindowDays
          ? CustomerCohort.newCustomer
          : CustomerCohort.established,
    );
  }
}
