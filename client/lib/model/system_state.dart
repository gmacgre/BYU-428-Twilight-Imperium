import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/ship_model.dart';

class SystemState{

  SystemState({
    required this.systemModel,
    planets, 
    airSpace, 
    activationTokens,
    this.systemOwner = -1
  }){
    if(airSpace != null){
      this.airSpace = airSpace;
    }
    if(systemModel.planets == null) {
      this.planets = null;
    }
    else {
      this.planets = systemModel.planets!.map((e) => PlanetState(planet: e, planetOwner: -1, numGroundForces: 0, numPDS: 0, existsSpaceDock: false)).toList();
    }
    if(planets != null) {
      this.planets = planets;
    }
    activationTokens ??= [];
  }
  List<ShipModel> airSpace = List.empty(growable: true);
  List<PlanetState>? planets;
  SystemModel systemModel;
  int systemOwner;
  late List<int> activationTokens;
}
