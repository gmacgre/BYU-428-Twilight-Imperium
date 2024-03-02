import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/player.dart';
import 'package:client/model/ship_model.dart';

class SystemState{

  SystemState({this.airSpace = const [], required this.systemModel});
  List<ShipModel> airSpace;
  List<PlanetState>? planets;
  SystemModel systemModel;
  Player? systemOwner;
  bool activated = false;
}
