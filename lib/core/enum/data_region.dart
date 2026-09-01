/// Cloud region where the user's data is stored (data residency). Canada
/// Central is the default for BC-based businesses (PIPA/PIPEDA).
enum DataRegion { caCentral, usEast, euWest, unknown }

extension DataRegionInfo on DataRegion {
  String get label => switch (this) {
        DataRegion.caCentral => 'AWS Canada (Central)',
        DataRegion.usEast => 'AWS US East',
        DataRegion.euWest => 'AWS EU (West)',
        DataRegion.unknown => 'Unknown region',
      };

  bool get isCanadian => this == DataRegion.caCentral;
}
