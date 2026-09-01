import 'package:objectbox/objectbox.dart';

/// Local click-frequency record for one suggestion prompt (Issue #201's
/// "Frequency Tracking... to prioritize [prompts] in the future") —
/// [promptText] is the natural key since prompts are generated text,
/// not a fixed catalog with stable IDs.
@Entity()
class PromptClickEntity {
  @Id()
  int id = 0;

  @Index(type: IndexType.value)
  String promptText;
  int clickCount;
  DateTime lastClickedAt;

  PromptClickEntity({
    this.id = 0,
    required this.promptText,
    this.clickCount = 0,
    required this.lastClickedAt,
  });
}
