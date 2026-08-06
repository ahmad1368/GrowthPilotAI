import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/barter_proposal_status.dart';

/// One merchant's structured counter-offer on a [BarterListingEntity]
/// (Issue #413, acceptance criterion 2) — the fields mirror the
/// listing's so [MatchBarterProposal] can score value, category, and
/// zone alignment between the two sides.
@Entity()
class BarterProposalEntity {
  @Id()
  int id = 0;

  @Index()
  int listingId;

  String proposerName;
  String offeredItemName;
  String offeredItemDescription;
  String offeredCategory;
  double offeredValue;
  String proposerZone;
  int dbStatus; // BarterProposalStatus index

  @Property(type: PropertyType.date)
  DateTime proposedAt;

  BarterProposalEntity({
    this.id = 0,
    required this.listingId,
    required this.proposerName,
    required this.offeredItemName,
    required this.offeredItemDescription,
    required this.offeredCategory,
    required this.offeredValue,
    required this.proposerZone,
    this.dbStatus = 0, // BarterProposalStatus.pending
    required this.proposedAt,
  });

  BarterProposalStatus get status => BarterProposalStatus.values[dbStatus];
  set status(BarterProposalStatus value) => dbStatus = value.index;
}
