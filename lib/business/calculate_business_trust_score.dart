import 'package:growth_pilot_ai/business/compute_account_longevity_score.dart';
import 'package:growth_pilot_ai/business/compute_business_trust_score.dart';
import 'package:growth_pilot_ai/business/compute_response_velocity_score.dart';
import 'package:growth_pilot_ai/business/compute_trust_score.dart';
import 'package:growth_pilot_ai/business/count_active_strikes.dart';
import 'package:growth_pilot_ai/business/resolve_trust_badge.dart';
import 'package:growth_pilot_ai/core/data/repositories/business_rating_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_message_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/chat_room_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/kyc_verification_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/strike_repository.dart';
import 'package:growth_pilot_ai/core/enum/trust_badge.dart';

typedef BusinessTrustResult = ({double score, TrustBadge badge});

/// The full "Reputation Microservice" pipeline (Issue #135), pulling
/// from the repositories #124/#125/#144 already built. [completionScore]
/// stays a caller-supplied neutral default until Procurement Matches
/// (#126) exist to compute a real completion rate from.
class CalculateBusinessTrustScore {
  static BusinessTrustResult call({
    required String businessId,
    required BusinessRatingRepository ratings,
    required StrikeRepository strikes,
    required ChatRoomRepository rooms,
    required ChatRoomMessageRepository messages,
    required KycVerificationRepository kyc,
    required double globalAverageRating,
    required DateTime accountCreatedAt,
    required DateTime now,
    double completionScore = 0.5,
  }) {
    final bayesianRating = ComputeBusinessTrustScore.call(
        ratings: ratings.getForBusiness(businessId), globalAverage: globalAverageRating, now: now);

    final businessRoomIds = rooms
        .getAll()
        .where((r) => r.participantAId == businessId || r.participantBId == businessId)
        .map((r) => r.id);
    final allMessages = [for (final id in businessRoomIds) ...messages.getForRoom(id)];

    final score = ComputeTrustScore.call(
      bayesianRating: bayesianRating,
      responseVelocityScore: ComputeResponseVelocityScore.call(allMessages, businessId),
      completionScore: completionScore,
      longevityScore: ComputeAccountLongevityScore.call(accountCreatedAt, now),
      activeStrikeCount: CountActiveStrikes.call(strikes.getAll(), businessId, now),
      verificationBonus: (kyc.getForUser(businessId)?.isVerified ?? false)
          ? ComputeTrustScore.kycVerificationBonus
          : 0.0,
    );

    return (score: score, badge: ResolveTrustBadge.call(score));
  }
}
