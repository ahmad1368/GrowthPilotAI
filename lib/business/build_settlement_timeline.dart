import 'package:growth_pilot_ai/core/data/entities/banking_gateway_transaction_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/escrow_account_entity.dart';
import 'package:growth_pilot_ai/core/enum/escrow_status.dart';
import 'package:growth_pilot_ai/core/enum/gateway_transaction_status.dart';
import 'package:growth_pilot_ai/core/models/settlement_timeline_step.dart';

/// Renders one gateway transaction's lifecycle as a 4-stage timeline
/// (Issue #426, acceptance criteria 1-2): payment authorization,
/// escrow holding, funds released, and delivery confirmed.
/// Crypto-rail transactions (#423) carry a real [EscrowAccountEntity]
/// (#415) whose release doubles as delivery confirmation, per
/// `BankingGatewaySettlementActions._releaseEscrow`; other rails have
/// no separate escrow step, so settlement itself confirms delivery.
class BuildSettlementTimeline {
  static List<SettlementTimelineStep> call(
    BankingGatewayTransactionEntity transaction,
    EscrowAccountEntity? escrow,
  ) {
    final status = transaction.status;
    final hasEscrow = escrow != null;
    final isCaptured = status == GatewayTransactionStatus.captured;
    final isSettled = status == GatewayTransactionStatus.settled;
    final isReleased = escrow?.status == EscrowStatus.released;

    return [
      SettlementTimelineStep(
        label: 'Payment Authorized',
        isComplete: true,
        isCurrent: status == GatewayTransactionStatus.authorized,
      ),
      SettlementTimelineStep(
        label: 'Escrow Holding',
        isApplicable: hasEscrow,
        isComplete: isSettled,
        isCurrent: isCaptured,
      ),
      SettlementTimelineStep(
        label: 'Funds Released',
        isComplete: isSettled,
        isCurrent: isSettled,
      ),
      SettlementTimelineStep(
        label: 'Delivery Confirmed',
        isComplete: hasEscrow ? isReleased : isSettled,
        isCurrent: false,
      ),
    ];
  }
}
