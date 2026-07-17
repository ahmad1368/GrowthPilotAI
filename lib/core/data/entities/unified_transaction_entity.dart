import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';
import 'package:growth_pilot_ai/core/models/tax_breakdown.dart';

/// One Plaid or accounting-software (QBO/Xero) transaction record (Issue
/// #69). Merging never deletes raw data — [mergeGroupId] just groups two
/// records the matching pipeline decided are the same real transaction.
@Entity()
class UnifiedTransactionEntity {
  @Id()
  int id = 0;
  @Unique()
  String externalId;
  int dbSource; // TransactionSource index
  double amount;
  @Index()
  DateTime date;
  String merchantName;
  int dbCategory; // BusinessCategory index
  String? rawCategory;
  double gst;
  double pst;
  double hst;
  String? mergeGroupId; // shared once merged; null = unmatched
  double? matchScore;

  UnifiedTransactionEntity({
    this.id = 0,
    required this.externalId,
    required this.dbSource,
    required this.amount,
    required this.date,
    required this.merchantName,
    this.dbCategory = 6, // BusinessCategory.uncategorized
    this.rawCategory,
    this.gst = 0,
    this.pst = 0,
    this.hst = 0,
    this.mergeGroupId,
    this.matchScore,
  });

  TransactionSource get source => TransactionSource.values[dbSource];
  BusinessCategory get category => BusinessCategory.values[dbCategory];
  TaxBreakdown get tax => TaxBreakdown(gst: gst, pst: pst, hst: hst);
  bool get isMerged => mergeGroupId != null;
}
