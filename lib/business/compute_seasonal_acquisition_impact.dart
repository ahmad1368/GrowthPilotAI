import 'package:growth_pilot_ai/business/canadian_statutory_holidays.dart';
import 'package:growth_pilot_ai/business/group_transactions_by_customer.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/seasonal_acquisition_impact.dart';

/// New-customer acquisition and post-window retention around each
/// statutory holiday (Issue #382), reusing [canadianStatutoryHolidays]
/// (#388) as the seasonal-window calendar and [GroupTransactionsByCustomer]
/// (#376) as the buyer-identity proxy — cost-per-acquisition is scoped
/// out since this app tracks no marketing spend.
class ComputeSeasonalAcquisitionImpact {
  static const _windowDays = 1;

  static List<SeasonalAcquisitionImpact> call(List<TransactionEntity> transactions) {
    final groups = GroupTransactionsByCustomer.call(transactions);
    if (groups.isEmpty) return [];

    final years = transactions.map((t) => t.date.year).toSet();

    final results = <SeasonalAcquisitionImpact>[];
    for (final holiday in canadianStatutoryHolidays) {
      var acquired = 0;
      var retained = 0;
      for (final year in years) {
        final holidayDate = DateTime(year, holiday.month, holiday.day);
        final start = holidayDate.subtract(const Duration(days: _windowDays));
        final end = holidayDate.add(const Duration(days: _windowDays));
        for (final group in groups) {
          if (group.firstPurchaseDate.isBefore(start) ||
              group.firstPurchaseDate.isAfter(end)) {
            continue;
          }
          acquired++;
          if (group.lastPurchaseDate.isAfter(end)) retained++;
        }
      }
      if (acquired == 0) continue;
      results.add(SeasonalAcquisitionImpact(
        holidayName: holiday.name,
        newCustomersAcquired: acquired,
        retainedCustomers: retained,
        retentionRate: retained / acquired,
      ));
    }

    return results..sort((a, b) => b.newCustomersAcquired.compareTo(a.newCustomersAcquired));
  }
}
