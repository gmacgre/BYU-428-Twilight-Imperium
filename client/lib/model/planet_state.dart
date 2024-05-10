import 'package:client/data/planet_data.dart';

class PlanetState {
  PlanetState({required this.planet, this.exhausted = false, required this.planetOwner, required this.numGroundForces});

  int planetOwner;
  PlanetModel planet;
  bool existsSpaceDock = false;
  bool exhausted = false;
  int numGroundForces;
  //TODO: Add ground troops and other units
}
