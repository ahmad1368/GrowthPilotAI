/// Sector-specific "Pro Tips" (Issue #104 scope item 4: "Metadata
/// Injection") layered onto #101's Narrative Generator — one line of
/// category-specific advice per sector, e.g. the issue's own "Check
/// battery health for this model year" example. `DEFAULT` backs the
/// "Fallbacks" AC.
const sectorProTips = <String, String>{
  'AUTOMOTIVE':
      'Check the maintenance history and mileage before committing — high-mileage vehicles depreciate fastest.',
  'ELECTRONICS':
      'Check battery health for this model year — depreciation accelerates once battery capacity drops.',
  'HOME_GOODS': 'Inspect for wear on high-touch surfaces; style-matched pieces resell fastest.',
  'SERVICES': "Check the provider's response time and recent ratings before booking.",
  'DEFAULT': 'Compare a few similar listings nearby before deciding.',
};
