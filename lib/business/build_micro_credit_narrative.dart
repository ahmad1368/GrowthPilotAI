import 'package:growth_pilot_ai/core/data/entities/micro_credit_loan_entity.dart';
import 'package:growth_pilot_ai/core/enum/micro_credit_loan_status.dart';

/// One-sentence read summarizing a merchant's loan history (Issue
/// #419), mirroring [BuildSeasonalCatalogNarrative]'s summary
/// pattern.
class BuildMicroCreditNarrative {
  static String call(List<MicroCreditLoanEntity> loans) {
    if (loans.isEmpty) {
      return 'No financing drawn yet.';
    }
    final outstanding = loans.where((l) => l.status == MicroCreditLoanStatus.disbursed).length;
    final defaulted = loans.where((l) => l.status == MicroCreditLoanStatus.defaulted).length;
    return '${loans.length} loan(s): $outstanding outstanding, $defaulted defaulted.';
  }
}
