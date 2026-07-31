import 'package:growth_pilot_ai/core/data/entities/staff_shift_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/staff_efficiency.dart';

/// Attributes transactions logged during each staff shift's window to
/// that shift, then derives volume and throughput metrics (Issue #379)
/// — the same date-window attribution [ComputeAdCampaignRoi] (#366) uses,
/// since this app has no per-transaction staff/cashier field to source
/// handling attribution from directly.
class ComputeStaffEfficiency {
  static List<StaffEfficiency> call(
    List<StaffShiftEntity> shifts,
    List<TransactionEntity> transactions,
  ) {
    final results = shifts.map((shift) {
      final handled = transactions
          .where((t) =>
              !t.date.isBefore(shift.startTime) &&
              !t.date.isAfter(shift.endTime))
          .toList();

      final transactionCount = handled.length;
      final totalVolume = handled.fold<double>(0, (sum, t) => sum + t.amount);
      final avgTicketSize =
          transactionCount == 0 ? 0.0 : totalVolume / transactionCount;
      final hours = shift.endTime.difference(shift.startTime).inMinutes / 60;
      final transactionsPerHour = hours <= 0 ? 0.0 : transactionCount / hours;

      return StaffEfficiency(
        staffName: shift.staffName,
        startTime: shift.startTime,
        endTime: shift.endTime,
        transactionCount: transactionCount,
        totalVolume: totalVolume,
        avgTicketSize: avgTicketSize,
        transactionsPerHour: transactionsPerHour,
      );
    }).toList();

    results.sort(
        (a, b) => b.transactionsPerHour.compareTo(a.transactionsPerHour));
    return results;
  }
}
