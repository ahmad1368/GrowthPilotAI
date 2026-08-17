import 'package:objectbox/objectbox.dart';

/// Single-row current legal-acceptance status (Issue #215) — mirrors the
/// issue's `acceptedTermsVersion`/`acceptedAt`/`dataUsageConsent` User
/// fields, same single-row pattern as [StoreProfileEntity] from #398.
@Entity()
class LegalConsentEntity {
  @Id()
  int id = 0;

  String? acceptedVersion;

  @Property(type: PropertyType.date)
  DateTime? acceptedAt;

  bool dataUsageConsent;

  LegalConsentEntity({
    this.id = 0,
    this.acceptedVersion,
    this.acceptedAt,
    this.dataUsageConsent = true,
  });
}
