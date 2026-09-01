import 'package:growth_pilot_ai/business/is_verified_business_rating.dart';
import 'package:growth_pilot_ai/core/data/entities/business_rating_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/chat_room_entity.dart';

/// Builds one submitted rating (Issue #125), computing its Verified
/// status from the rater/business chat history.
class BuildBusinessRating {
  static BusinessRatingEntity call({
    required String businessId,
    required String raterId,
    required double punctuality,
    required double accuracy,
    required double communication,
    required List<ChatRoomEntity> existingRooms,
    required DateTime now,
  }) {
    return BusinessRatingEntity(
      businessId: businessId,
      raterId: raterId,
      punctuality: punctuality,
      accuracy: accuracy,
      communication: communication,
      isVerified: IsVerifiedBusinessRating.call(existingRooms, raterId, businessId),
      createdAt: now,
    );
  }
}
