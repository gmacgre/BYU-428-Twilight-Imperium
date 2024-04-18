import 'package:client/data/planet_data.dart';
import 'package:client/model/player.dart';

class PlanetState {
  PlanetState({required this.planet});

  Player? planetOwner;
  PlanetModel planet;
  bool existsSpaceDock = false;
  //TODO: Add ground troops and other units
}
