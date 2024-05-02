import 'package:client/data/datacache.dart';
import 'package:client/data/system_data.dart';
import 'package:client/model/request_response/error_response.dart';
import 'package:client/model/request_response/gameState/game_state_response.dart';
import 'package:client/model/system_state.dart';
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
      List<List<SystemState>> newBoard = List.empty(growable: true);

      //This loads the cache with the new version of the map
      List<SystemContentRow> map = res.map.map;
      for(int i = 0; i < map.length; i++) {
        List<SystemState> newRow = List.empty(growable: true);
        List<SystemContent> row = map[i].row;
        for(int j = 0; j < row.length; j++) {
          SystemContent content = row[j];
          print(content.systemName);
          print(SystemData.systemList[content.systemName]);
          //System Constant Data
          SystemState newState = SystemState(systemModel: SystemData.systemList[content.systemName]!);
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