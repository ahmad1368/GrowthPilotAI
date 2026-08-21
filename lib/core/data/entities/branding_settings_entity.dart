import 'dart:typed_data';
import 'package:objectbox/objectbox.dart';

/// Local stand-in for Issue #257's Node.js/S3/Puppeteer branding
/// pipeline ("upload logo to S3... inject brand color into PDF
/// template server-side") — no backend exists in this repo, so the
/// logo and brand color are stored as a single local row and read
/// directly by the on-device PDF builders (see
/// `BuildPdfBrandingHeaderWidget`). Single-row table: callers always
/// read/replace the first entity via `BrandingSettingsRepository`.
@Entity()
class BrandingSettingsEntity {
  @Id()
  int id = 0;

  String companyName;
  String brandColorHex; // e.g. '#2563EB'
  Uint8List? logoBytes;

  @Property(type: PropertyType.date)
  DateTime updatedAt;

  BrandingSettingsEntity({
    this.id = 0,
    required this.companyName,
    required this.brandColorHex,
    this.logoBytes,
    required this.updatedAt,
  });
}
