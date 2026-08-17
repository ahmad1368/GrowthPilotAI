import 'package:objectbox/objectbox.dart';

/// Single-row state for the "Microphone Audio Monitoring" mock consent
/// toggle (Issue #540) — this is a UI-only placeholder: GrowthPilotAI
/// does not request microphone permission or capture audio anywhere.
/// [optedIn] defaults to false (Privacy by Design, same as #218/#215).
@Entity()
class MicrophoneConsentEntity {
  @Id()
  int id = 0;

  bool optedIn;

  @Property(type: PropertyType.date)
  DateTime? decidedAt;

  MicrophoneConsentEntity({this.id = 0, this.optedIn = false, this.decidedAt});
}
