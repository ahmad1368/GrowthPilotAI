import 'package:objectbox/objectbox.dart';

/// A provider's "Quick Quote" or "Request for More Info" reply to a
/// [ProcurementRequestEntity] (Issue #126) — [quoteAmount] is null for a
/// plain info request, set for a quote.
@Entity()
class ProcurementResponseEntity {
  @Id()
  int id = 0;

  @Index()
  int requestId;

  String providerId;
  double? quoteAmount;
  String message;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  ProcurementResponseEntity({
    this.id = 0,
    required this.requestId,
    required this.providerId,
    this.quoteAmount,
    required this.message,
    required this.createdAt,
  });

  bool get isQuote => quoteAmount != null;
}
