/// Client-side mirror of the backend transaction DTO constraints. Each method
/// returns null when valid, or a user-friendly message for the Flutter UI.
class TransactionInputValidator {
  static const Set<String> _currencies = {'CAD', 'USD'};

  static String? merchantName(String? value) {
    final v = value?.trim() ?? '';
    if (v.length < 3) return 'Merchant name must be at least 3 characters';
    if (v.length > 100) return 'Merchant name must be at most 100 characters';
    return null;
  }

  static String? amount(num? value) {
    if (value == null) return 'Amount is required';
    if (value <= 0) return 'Amount must be a positive number';
    final cents = value * 100;
    if ((cents - cents.roundToDouble()).abs() > 1e-9) {
      return 'Amount can have at most 2 decimal places';
    }
    return null;
  }

  static String? currency(String? value) {
    if (value == null || !_currencies.contains(value.toUpperCase())) {
      return 'Currency must be CAD or USD';
    }
    return null;
  }
}
