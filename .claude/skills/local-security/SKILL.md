---
name: local-security
description: Use this skill when working with user authentication, PIN codes, encryption keys, biometrics, or storing session tokens/API keys.
---

When handling sensitive or financial user data in GrowthPilotAI, strictly enforce security protocols:

1. **Secure Storage**: Never save passwords, PINs, or raw API tokens inside standard ObjectBox boxes or SharedPreferences. Always use `flutter_secure_storage` (Keychain/Keystore).
2. **Data Obfuscation**: Obfuscate sensitive user metrics or account balances when logging or passing data to non-secure internal layers.
3. **Biometric Checks**: Ensure biometric authentication flows (using `local_auth`) fail gracefully, handle device-level lockouts, and never store biometric patterns inside the app.
4. **Environment Keys**: Do not hardcode remote endpoint URLs or API keys in code. Read them dynamically through `String.fromEnvironment` or a secured environment config setup.
