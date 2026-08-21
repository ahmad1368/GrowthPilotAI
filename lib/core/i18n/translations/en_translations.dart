/// English strings (Issue #429) — the eagerly-loaded default bundle;
/// every other locale is fetched lazily via [LocaleBundleLoader] and
/// falls back to this map for any key it doesn't define.
const Map<String, String> enTranslations = {
  'app_name': 'GrowthPilot AI',
  'common_save': 'Save',
  'common_cancel': 'Cancel',
  'common_loading': 'Loading...',
  'common_error': 'Something went wrong',
  'common_retry': 'Retry',
  'nav_home': 'Home',
  'nav_settings': 'Settings',
  'nav_analytics': 'Analytics',
  'settings_language_title': 'Language',
  'settings_language_subtitle': 'Choose your app language',
  'onboarding_welcome_title': 'Welcome to GrowthPilot AI',
  'onboarding_welcome_subtitle': 'Choose your preferred language to get started',
  'onboarding_choose_language': 'Select a language',
  'onboarding_suggested_language': 'Suggested',
  'onboarding_continue': 'Continue',
};
