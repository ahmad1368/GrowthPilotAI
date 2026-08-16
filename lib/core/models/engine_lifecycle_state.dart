import 'package:flutter/foundation.dart';

/// On-device inference engine's load state (Issue #197 scaffolding —
/// [isLoaded] never reflects a real MediaPipe engine yet, see PR notes).
@immutable
class EngineLifecycleState {
  final bool isLoaded;
  final DateTime? lastActiveAt;

  const EngineLifecycleState({required this.isLoaded, required this.lastActiveAt});

  factory EngineLifecycleState.initial() =>
      const EngineLifecycleState(isLoaded: false, lastActiveAt: null);

  EngineLifecycleState copyWith({bool? isLoaded, DateTime? lastActiveAt}) => EngineLifecycleState(
        isLoaded: isLoaded ?? this.isLoaded,
        lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      );
}
