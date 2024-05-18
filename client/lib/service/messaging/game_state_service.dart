import 'package:client/res/coordinate.dart';
import 'package:client/data/datacache.dart';
import 'package:client/data/ship_data.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/planet_state.dart';
import 'package:client/model/request_response/error_response.dart';
import 'package:client/model/request_response/gameState/game_state_response.dart';
import 'package:client/model/ship_model.dart';
import 'package:client/model/system_state.dart';
import 'package:client/model/turn_phase.dart';
import 'package:client/service/http/http_service.dart';
import 'package:client/service/json/json_encoder.dart';
import 'package:client/service/messaging/service_observer.dart';

class GameStateService implements HTTPServiceObserver {
  late final HTTPService _service;
  late final GameStateServiceObserver _observer;

  GameStateService(this._observer) {
    _service = HTTPService(this);
  }

  void getGameState(String userToken) {
    Map<String, String> headers = {
      'token': userToken
    };
    _service.getRequest('/gameState', headers);
  }

  @override
  void processSuccess(String body) {
    try {
      GameStateResponse res = JSONEncoder.decodeGameStateResponse(body);
      DataCache cache = DataCache.instance;
      cache.players = res.players;
      cache.activePlayer = res.world.activePlayer;
      cache.activeSystem = Coords(res.world.coords.x, res.world.coords.y);
      if (res.world.activePlayer == cache.userSeatNumber) {
        cache.phase = res.world.phase;
      }
      else {
        cache.phase = TurnPhase.observation;
      }
      List<List<SystemState>> newBoard = List.empty(growable: true);

      //This loads the cache with the new version of the map
      List<TileRow> map = res.map.map;
      for(int i = 0; i < map.length; i++) {
        List<SystemState> newRow = List.empty(growable: true);
        List<Tile> row = map[i].row;
        for(int j = 0; j < row.length; j++) {
          Tile content = row[j];
          //System Constant Data
          List<ShipModel> airSpace = _transferAirspace(content.state.ships, content.state.owner);
          List<PlanetState> internalStates = _generatePlanetStates(content);
          SystemState newState = SystemState(
            systemModel: SystemData.systemList[content.systemName]!,
            airSpace: airSpace,
            systemOwner: content.state.owner,
            planets: internalStates
          );
          newRow.add(newState);
        }
        newBoard.add(newRow);
      }
      cache.boardState = newBoard;
      _observer.notifySuccess();
    } on FormatException  catch (e){
      _observer.notifyFailure('Error Processing Successful /gameState: ${e.message}');
    }
  }

  List<PlanetState> _generatePlanetStates(Tile system) {
    List<PlanetState> toReturn = [];
    for (int i = 0; i < system.state.planets.length; i++) {
      toReturn.add(PlanetState(
        planet: SystemData.systemList[system.systemName]!.planets![i],
        planetOwner: system.state.planets[i].owner,
        numGroundForces: system.state.planets[i].numGroundForces,
        numPDS: system.state.planets[i].numPds,
        existsSpaceDock: system.state.planets[i].hasSpacedock        
      ));
    }
    return toReturn;
  }

  List<ShipModel> _transferAirspace(List<ResponseShip> ships, int owner) {
    if (owner == -1) {
      return const [];
    }
    List<ShipModel> toReturn = [];
    ShipType t = ShipType.fighter;
    // TODO: Check here for race specific ships
    for (ResponseShip s in ships) {
      t = ShipType.fromString(s.shipClass);
      toReturn.add(ShipData.defaultData[t]!);
    }
    return toReturn;
  }

  @override
  void processFailure(int errorCode, String body) {
    try {
      ErrorResponse res = JSONEncoder.decodeErrorResponse(body);
      _observer.notifyFailure("$errorCode: ${res.message}");
    } on FormatException  catch (e){
      _observer.notifyFailure('Error Processing /gameState: ${e.message}');
    }
  }

  @override
  void processException(String body) {
    _observer.notifyFailure('Error getting game state - $body');
  }
}

abstract class GameStateServiceObserver extends ServiceObserver {
  void notifySuccess();
}