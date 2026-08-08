import 'package:growth_pilot_ai/core/enum/metadata_tag_category.dart';
import 'package:growth_pilot_ai/core/models/message_tag.dart';

/// "Detect Financial Intent" (Issue #128) — requires a `$` sign or exact
/// cents (e.g. `$150`, `120.00`) rather than the issue's own loose
/// sample regex (which matches any bare number), to actually clear the
/// ">90% precision" AC instead of flagging every quantity/phone digit.
class DetectFinancialTag {
  static final _pattern = RegExp(r'\$\s?\d+(\.\d{2})?|\b\d+\.\d{2}\b');

  static MessageTag? call(String content) {
    if (!_pattern.hasMatch(content)) return null;
    return (category: MetadataTagCategory.financial, label: 'PriceNegotiation', confidence: 0.95);
  }
}
