import 'package:client/model/player.dart';
import 'package:client/model/turn_phase.dart';


//This is three or four nested class levels of hell. :(
class GameStateResponse {
  final GlobalState world;
  final WorldMap map;
  final List<Player> players;
  GameStateResponse({
    required this.map,
    required this.players,
    required this.world
  });

  factory GameStateResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'map': Map<String, dynamic> map,
        'players': List<dynamic> players,
        'world': Map<String, dynamic> world
      } =>
        GameStateResponse(
          players: players.map((player) => Player.fromJson(player)).toList(),
          map: WorldMap.fromJson(map),
          world: GlobalState.fromJson(world)
        ),
      _ => throw const FormatException('Failed to load GameStateResponse')
    };
  }

  Map<String, dynamic> toJson() => {
    'map': map,
    'players': players
  };
  
}

class WorldMap {
  final List<SystemContentRow> map;

  WorldMap({
    required this.map
  });

  factory WorldMap.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'map': List<dynamic> outerMap
      } =>
        WorldMap(
          map: outerMap.map((row) => SystemContentRow.fromJson(row)).toList()
        ),
      _ => throw const FormatException('Failed to load WorldMap')
    };
  }
}

class SystemContentRow {
  final List<SystemContent> row;

  SystemContentRow({
    required this.row
  });

  factory SystemContentRow.fromJson(List<dynamic> json) {
    List<SystemContent> inner = json.map((sc) => SystemContent.fromJson(sc)).toList();
    return SystemContentRow(row: inner);
  }
}

class SystemContent {
  final List<int> tokens;
  final String systemName;
  final List<ResponseShipModel> ships;

  SystemContent({
    required this.tokens,
    required this.systemName,
    required this.ships
  });

  factory SystemContent.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'tokens': List<dynamic> tokens,
        'system': String system,
        'ships': List<dynamic> ships
      } =>
        SystemContent(
          tokens: List<int>.from(tokens),
          systemName: system,
          ships: List<ResponseShipModel>.from(ships.map((ship) => ResponseShipModel.fromJson(ship)))
        ),
      _ => throw const FormatException('Failed to load SystemContent')
    };
  }
}

class ResponseShipModel {
  final String shipClass;
  final ResponseShipCoords coords;

  ResponseShipModel({
    required this.shipClass,
    required this.coords
  });

  factory ResponseShipModel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'shipClass': String shipClass,
        'coords': Map<String, dynamic> coords
      } =>
        ResponseShipModel(
          shipClass: shipClass,
          coords: ResponseShipCoords.fromJson(coords),
        ),
      _ => throw const FormatException('Failed to load ResponseShipModel')
    };
  }
}

class ResponseShipCoords {
  final int x;
  final int y;

  ResponseShipCoords({
    required this.x,
    required this.y
  });

  factory ResponseShipCoords.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'x': int x,
        'y': int y
      } =>
        ResponseShipCoords(x: x, y: y),
      _ => throw const FormatException('Failed to load ResponseShipCoords')
    };
  }
}

class GlobalState {
  int activePlayer;
  TurnPhase phase;
  ResponseShipCoords coords;


  GlobalState({
    required this.activePlayer,
    required this.phase,
    required this.coords
  });

  factory GlobalState.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'activePlayer': int activePlayer,
        'nextCommand': String phase,
        'activeSystem': Map<String, dynamic> coords
      } =>
        GlobalState(
          activePlayer: activePlayer,
          phase: TurnPhaseFactory.fromString(phase),
          coords: ResponseShipCoords.fromJson(coords)
        ),
      _ => throw const FormatException('Failed to load GlobalState')
    };
  }
}