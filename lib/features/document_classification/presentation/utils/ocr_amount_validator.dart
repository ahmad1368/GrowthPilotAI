/// [Issue #27] Validates the confirmation screen's Amount field. Save used
/// to silently default an unparseable/non-positive amount to 0.0 and save
/// anyway; the issue's own AC requires blocking the save instead.
class OcrAmountValidator {
  static String? validate(String? value) {
    final amount = double.tryParse(value ?? '');
    if (amount == null || amount <= 0) {
      return 'مبلغ معتبر وارد کنید';
    }
    return null;
  }
}
