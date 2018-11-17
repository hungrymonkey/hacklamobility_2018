import 'package:flutter/foundation.dart';

class MapConfiguration {
  MapConfiguration({
    @required this.scooter,
    @required this.car,
    @required this.transit,
    @required this.walking
  }) : assert(scooter != null),
    assert(car != null),
    assert(transit != null),
    assert(walking != null);
    final bool car;
    final bool scooter;
    final bool walking;
    final bool transit;
    MapConfiguration copywith({
       bool car,
      bool scooter,
      bool walking,
      bool transit,
    }) {return MapConfiguration(
      car: car ?? this.car,
      scooter: scooter ?? this.scooter,
      transit: transit ?? this.transit,
      walking: walking ?? this.walking,
    );
  }
}