import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/analyze_negotiation_chat.dart';
import 'package:growth_pilot_ai/business/is_high_risk_sender.dart';
import 'package:growth_pilot_ai/business/should_trigger_copilot_analysis.dart';
import 'package:growth_pilot_ai/core/models/negotiation_analysis.dart';

/// "AI Mediation Layer" (Issue #152) state for the chat "Smart
/// Suggestion" bar. No OpenAI/LangChain call is made — [AnalyzeNegotiationChat]
/// runs entirely on-device; see the PR notes for what a real LLM would add.
class NegotiationCopilotController extends GetxController {
  final analysis = Rx<NegotiationAnalysis?>(null);
  final isHighRisk = false.obs;

  void analyzeIfActive(
    List<String> recentMessages,
    String latestMessage, {
    required bool isUserActiveInChat,
    required bool senderHasCriticalStrike,
  }) {
    if (!ShouldTriggerCopilotAnalysis.call(isUserActiveInChat: isUserActiveInChat)) return;

    final result = AnalyzeNegotiationChat.call(recentMessages, latestMessage, DateTime.now());
    analysis.value = result;
    isHighRisk.value = IsHighRiskSender.call(
        messageFlagged: result.riskFlagged, hasCriticalStrike: senderHasCriticalStrike);
  }

  void dismiss() {
    analysis.value = null;
    isHighRisk.value = false;
  }
}
