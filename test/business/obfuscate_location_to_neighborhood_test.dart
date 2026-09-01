import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/obfuscate_location_to_neighborhood.dart';

void main() {
  test('resolves coordinates to their nearest named neighborhood', () {
    expect(ObfuscateLocationToNeighborhood.call(49.1913, -122.8490), 'Whalley');
    expect(ObfuscateLocationToNeighborhood.call(49.2827, -123.1207), 'Downtown Vancouver');
  });

  test('picks the closest match for an in-between point', () {
    // Slightly off from Guildford's exact coordinates but still nearest to it.
    expect(ObfuscateLocationToNeighborhood.call(49.1560, -122.8020), 'Guildford');
  });
}
