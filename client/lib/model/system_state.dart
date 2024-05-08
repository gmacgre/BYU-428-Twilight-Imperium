import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';

class SystemState{

  SystemState({
    required this.systemModel,
    planets, 
    airSpace, 
    activationTokens
  }){
    if(airSpace != null){
      this.airSpace = airSpace;
    }
    if(planets != null) {
      this.planets = planets;
    }
    else if(systemModel.planets == null) {
      this.planets = null;
    }
    else {
      this.planets = systemModel.planets!.map((e) => PlanetState(planet: e)).toList();
    }
    activationTokens ??= [];
  }
  List<ShipModel> airSpace = List.empty(growable: true);
  List<PlanetState>? planets;
  SystemModel systemModel;
  Player? systemOwner;
  late List<int> activationTokens;
}
