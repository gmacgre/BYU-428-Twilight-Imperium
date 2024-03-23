import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';

class SystemState{

  SystemState({airSpace, required this.systemModel}){
    if(airSpace != null){
      this.airSpace = airSpace;
    }
  }
  List<ShipModel> airSpace = List.empty(growable: true);
  List<PlanetState>? planets;
  SystemModel systemModel;
  Player? systemOwner;
}
