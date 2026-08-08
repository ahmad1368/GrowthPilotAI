import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/kyc_verification_status.dart';

/// One user's KYC submission (Issue #144) — document bytes are stored
/// directly (like [ImageVariantEntity]/#139), not behind a "Cold
/// Storage" S3 bucket, since no cloud storage exists locally.
/// [rejectionReason] carries the "clear reason for rejection" AC.
@Entity()
class KycVerificationEntity {
  @Id()
  int id = 0;

  @Unique()
  String userId;

  int dbStatus; // KycVerificationStatus index
  Uint8List? idDocumentBytes;
  Uint8List? businessDocumentBytes;
  String? rejectionReason;

  @Property(type: PropertyType.date)
  DateTime? submittedAt;

  @Property(type: PropertyType.date)
  DateTime? reviewedAt;

  KycVerificationEntity({
    this.id = 0,
    required this.userId,
    this.dbStatus = 0, // KycVerificationStatus.none
    this.idDocumentBytes,
    this.businessDocumentBytes,
    this.rejectionReason,
    this.submittedAt,
    this.reviewedAt,
  });

  KycVerificationStatus get status => KycVerificationStatus.values[dbStatus];
  set status(KycVerificationStatus value) => dbStatus = value.index;
  bool get isVerified => status == KycVerificationStatus.verified;
}
