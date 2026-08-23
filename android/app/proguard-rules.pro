# Issue #183: R8/ProGuard keep rules for release builds. Minification
# without these breaks reflection-based plugins at runtime with no
# compile-time warning, so each rule below is tied to a real dependency
# in pubspec.yaml, not a guess.

# Google ML Kit (text recognition + document scanner) — reflection-heavy.
-keep class com.google.mlkit.** { *; }
-keep class com.google.android.gms.internal.mlkit_vision_text_common.** { *; }
-dontwarn com.google.mlkit.**

# TensorFlow Lite (on-device AI inference).
-keep class org.tensorflow.lite.** { *; }
-dontwarn org.tensorflow.lite.**

# ObjectBox (native library loading via reflection).
-keep class io.objectbox.** { *; }
-dontwarn io.objectbox.**

# flutter_secure_storage (Android Keystore reflection on some OEM builds).
-keep class com.it_nomads.fluttersecurestorage.** { *; }
