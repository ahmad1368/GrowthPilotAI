import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/business_category.dart';
import 'package:growth_pilot_ai/core/enum/chat_sticker.dart';
import 'package:growth_pilot_ai/core/enum/pulse_category.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';
import 'package:growth_pilot_ai/core/enum/transaction_source.dart';

/// Pins the declaration order of enums backed by a persisted ObjectBox
/// `int db*` index field (Issue #180, reinterpreted per docs/adr/0006 —
/// no NestJS schema exists to sync against here, but reordering one of
/// these enums silently reinterprets every already-stored row as the
/// wrong value, which is the same "silent type mismatch" #180 warns
/// about). If one of these fails, you reordered/renamed/removed a value
/// — see the ADR for what to do instead (append at the end, or
/// @Deprecated in place).
///
/// This covers the 5 most consequential persisted enums as a worked
/// example of the pattern, not all 100+ that exist in this codebase —
/// extend this file (or add a sibling one) as new persisted enums are
/// added or as existing ones are identified as worth protecting.
void main() {
  test('TransactionSource (UnifiedTransactionEntity.dbSource)', () {
    expect(
      TransactionSource.values.map((v) => v.name).toList(),
      ['plaid', 'quickbooks', 'xero', 'manualScan', 'apiImport'],
    );
  });

  test('PulseCategory (PulseEventEntity.dbCategory)', () {
    expect(
      PulseCategory.values.map((v) => v.name).toList(),
      ['financialBlocker', 'operationalHazard', 'regulatoryUpdate'],
    );
  });

  test('BusinessCategory (used to normalize raw Plaid categories)', () {
    expect(
      BusinessCategory.values.map((v) => v.name).toList(),
      ['officeSupplies', 'rent', 'utilities', 'travel', 'meals', 'software', 'uncategorized'],
    );
  });

  test('ChatSticker (chat message body encodes the sticker by name)', () {
    expect(
      ChatSticker.values.map((v) => v.name).toList(),
      ['deal', 'handshake', 'check', 'fire', 'clock', 'star', 'warning', 'question'],
    );
  });

  test('SubscriptionTier (persisted AND compared by .index for tier weight)', () {
    expect(
      SubscriptionTier.values.map((v) => v.name).toList(),
      ['starter', 'pro', 'enterprise'],
    );
  });
}
