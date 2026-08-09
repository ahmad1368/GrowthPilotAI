import 'package:growth_pilot_ai/business/extract_delivery_date_term.dart';
import 'package:growth_pilot_ai/business/extract_price_term.dart';
import 'package:growth_pilot_ai/business/extract_quantity_term.dart';
import 'package:growth_pilot_ai/core/models/negotiation_terms.dart';

/// "Feed the last 20 messages into a Negotiation Prompt" (Issue #152) —
/// scans oldest-to-newest so the most recently mentioned value for each
/// field wins, approximating "what was actually agreed."
class ExtractNegotiationTerms {
  static const contextWindow = 20;

  static NegotiationTerms call(List<String> recentMessages, DateTime now) {
    final window = recentMessages.length > contextWindow
        ? recentMessages.sublist(recentMessages.length - contextWindow)
        : recentMessages;

    double? price;
    int? quantity;
    DateTime? deliveryDate;
    for (final message in window) {
      price = ExtractPriceTerm.call(message) ?? price;
      quantity = ExtractQuantityTerm.call(message) ?? quantity;
      deliveryDate = ExtractDeliveryDateTerm.call(message, now) ?? deliveryDate;
    }
    return (price: price, quantity: quantity, deliveryDate: deliveryDate);
  }
}
