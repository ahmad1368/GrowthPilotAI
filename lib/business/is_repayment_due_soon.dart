import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// Whether an outstanding loan's due date is within the reminder
/// window (Issue #419, acceptance criterion 4) — a derived read
/// surfaced as a UI banner, the same simplification
/// [IsBalanceReminderDue] (#417) uses in place of a real scheduled
/// push notification.
class IsRepaymentDueSoon {
  static bool call(MicroCreditLoanEntity loan, DateTime now, {int reminderWindowDays = 7}) {
    if (loan.status != MicroCreditLoanStatus.disbursed) return false;
    final reminderStart = loan.dueDate.subtract(Duration(days: reminderWindowDays));
    return now.isAfter(reminderStart);
  }
}
