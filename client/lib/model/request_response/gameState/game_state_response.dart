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
        'board': Map<String, dynamic> map,
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
  final List<TileRow> map;

  WorldMap({
    required this.map
  });

  factory WorldMap.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'map': List<dynamic> outerMap
      } =>
        WorldMap(
          map: outerMap.map((row) => TileRow.fromJson(row)).toList()
        ),
      _ => throw const FormatException('Failed to load WorldMap')
    };
  }
}

class TileRow {
  final List<Tile> row;

  TileRow({
    required this.row
  });

  factory TileRow.fromJson(List<dynamic> json) {
    List<Tile> inner = json.map((sc) => Tile.fromJson(sc)).toList();
    return TileRow(row: inner);
  }
}

class Tile {
  final TileState state;
  final String systemName;

  Tile({
    required this.state,
    required this.systemName,
  });

  factory Tile.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'state': Map<String, dynamic> state,
        'system': String system,
      } =>
        Tile(
          state: TileState.fromJson(state),
          systemName: system,
        ),
      _ => throw const FormatException('Failed to load Tile')
    };
  }
}

class TileState {
  final int owner;
  final List<ResponseShip> ships;
  final Set<int> tokens;
  final List<ResponsePlanetState> planets;

  TileState({
    required this.owner,
    required this.ships,
    required this.tokens,
    required this.planets
  });
  factory TileState.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'owner': int owner,
        'ships': List<dynamic> ships,
        'tokens': List<dynamic> tokens,
        'planetStates': List<dynamic> planetStates,
      } =>
        TileState(
          owner: owner,
          ships: ships.map((ship) => ResponseShip.fromJson(ship)).toList(),
          tokens: tokens.map((e) => e as int).toSet(), // tokens.toSet(),
          planets: planetStates.map((state) => ResponsePlanetState.fromJson(state)).toList(),
        ),
      _ => throw const FormatException('Failed to load TileState')
    };
  }
}

class ResponseShip {
  Coords coords;
  String shipClass;
  ResponseShip({
    required this.coords,
    required this.shipClass
  });

  factory ResponseShip.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'coords': Map<String, dynamic> coords,
        'shipClass': String shipClass
      } =>
        ResponseShip(
          coords: Coords.fromJson(coords),
          shipClass: shipClass,
        ),
      _ => throw const FormatException('Failed to load Ship')
    };
  }
}

// TODO: Complete as we add Ground Forces, PDS and Spacedocks
class ResponsePlanetState {
  final int owner;
  final int numPds;
  final bool hasSpacedock;
  final int numGroundForces;
  ResponsePlanetState({
    required this.owner,
    required this.numGroundForces,
    required this.numPds,
    required this.hasSpacedock
  });
  factory ResponsePlanetState.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'owner': int o,
        'numPds': int nPds,
        'hasSpacedock': bool hS,
        'numGroundForces': int nGF
      } => 
        ResponsePlanetState(owner: o, numGroundForces: nGF, numPds: nPds, hasSpacedock: hS),
      _ => throw const FormatException('Failed to load PlanetState')
    };
  }
}


class GlobalState {
  int activePlayer;
  TurnPhase phase;
  Coords coords;


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
          coords: Coords.fromJson(coords)
        ),
      _ => throw const FormatException('Failed to load GlobalState')
    };
  }
}

class Coords {
  final int x;
  final int y;

  Coords({
    required this.x,
    required this.y
  });

  factory Coords.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'x': int x,
        'y': int y
      } =>
        Coords(x: x, y: y),
      _ => throw const FormatException('Failed to load ResponseShipCoords')
    };
  }
}