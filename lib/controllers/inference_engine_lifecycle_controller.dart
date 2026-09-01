import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/has_enough_ram_for_inference.dart';
import 'package:growth_pilot_ai/business/should_unload_inference_engine.dart';
import 'package:growth_pilot_ai/core/models/engine_lifecycle_state.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// Load/unload lifecycle policy for the on-device inference engine
/// (Issue #197 scaffolding) — no real MediaPipe engine exists yet (see
/// Issue #196's PR notes), so [attemptLoad]/[unloadIfStale] only toggle
/// local state; a real integration would call native load/free here.
class InferenceEngineLifecycleController extends GetxController {
  final Rx<EngineLifecycleState> state = Rx(EngineLifecycleState.initial());

  OmniResult<void> attemptLoad(int availableRamMb) async {
    if (!HasEnoughRamForInference.call(availableRamMb)) {
      return OmniResponse.error(
          'Not enough free memory to start the AI engine. Close some apps and try again.');
    }
    state.value = state.value.copyWith(isLoaded: true, lastActiveAt: DateTime.now());
    return OmniResponse.success(null);
  }

  void markActive() {
    if (!state.value.isLoaded) return;
    state.value = state.value.copyWith(lastActiveAt: DateTime.now());
  }

  void unloadIfStale() {
    if (!state.value.isLoaded) return;
    if (ShouldUnloadInferenceEngine.call(state.value.lastActiveAt, DateTime.now())) {
      state.value = EngineLifecycleState.initial();
    }
  }
}
